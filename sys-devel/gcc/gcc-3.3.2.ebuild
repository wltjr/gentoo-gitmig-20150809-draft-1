# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.3.2.ebuild,v 1.24 2005/05/24 04:28:09 vapier Exp $

inherit eutils flag-o-matic libtool versionator

# The next command strips most flags from CFLAGS/CXXFLAGS.  If you do 
# not like it, comment it out, but do not file bugreports if you run into
# problems.
do_filter_flags() {
	strip-flags

	# In general gcc does not like optimization ... we'll add -O2 where safe
	filter-flags -O?

	# Compile problems with these (bug #6641 among others)...
	#filter-flags -fno-exceptions -fomit-frame-pointer -fforce-addr
}

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
#GCC_BRANCH_VER="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
#GCC_RELEASE_VER="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"
GCC_BRANCH_VER="$(get_version_component_range 1-2)"
GCC_RELEASE_VER="$(get_version_component_range 1-3)"

LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${GCC_RELEASE_VER}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${GCC_BRANCH_VER}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${GCC_BRANCH_VER}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${GCC_BRANCH_VER/\.*/}"

# ProPolice version
PP_VER="3_3"
PP_FVER="${PP_VER//_/.}-4"

# Patch tarball support ...
#PATCH_VER="1.0"
PATCH_VER=

# Snapshot support ...
#SNAPSHOT="2002-08-12"
SNAPSHOT=

# Branch update support ...
GCC_RELEASE_VER="${PV}"  # Tarball, etc used ...

#BRANCH_UPDATE="20021208"
BRANCH_UPDATE=

if [ -z "${SNAPSHOT}" ]
then
	S="${WORKDIR}/${PN}-${GCC_RELEASE_VER}"
	SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${PN}-${GCC_RELEASE_VER}.tar.bz2"

	if [ -n "${PATCH_VER}" ]
	then
		SRC_URI="${SRC_URI}
		         mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"
	fi

	if [ -n "${BRANCH_UPDATE}" ]
	then
		SRC_URI="${SRC_URI}
		         mirror://gentoo/${PN}-${GCC_RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch.bz2"
	fi
else
	S="${WORKDIR}/gcc-${SNAPSHOT//-}"
	SRC_URI="ftp://sources.redhat.com/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT//-}.tar.bz2"
fi
if [ -n "${PP_VER}" ]
then
	SRC_URI="${SRC_URI}
		mirror://gentoo/protector-${PP_FVER}.tar.gz
		http://www.research.ibm.com/trl/projects/security/ssp/gcc${PP_VER}/protector-${PP_FVER}.tar.gz"
fi
#SRC_URI="${SRC_URI}
#	mirror://gentoo/${P}-manpages.tar.bz2"

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++ and java compilers"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-* hppa"
IUSE="static nls bootstrap java build X multilib emul-linux-x86"

# Ok, this is a hairy one again, but lets assume that we
# are not cross compiling, than we want SLOT to only contain
# $PV, as people upgrading to new gcc layout will not have
# their old gcc unmerged ...
SLOT="3.3"

# We need the later binutils for support of the new cleanup attribute.
# 'make check' fails for about 10 tests (if I remember correctly) less
# if we use later bison.
DEPEND="virtual/libc
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.1
	amd64? ( multilib? ( >=app-emulation/emul-linux-x86-baselibs-1.0 ) )
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/libc
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="sys-devel/gcc-config"


chk_gcc_version() {
	# This next bit is for updating libtool linker scripts ...
	local OLD_GCC_VERSION="`gcc -dumpversion`"
	local OLD_GCC_CHOST="$(gcc -v 2>&1 | egrep '^Reading specs' |\
	                       sed -e 's:^.*/gcc-lib/\([^/]*\)/[0-9]\+.*$:\1:')"

	if [ "${OLD_GCC_VERSION}" != "${GCC_RELEASE_VER}" ]
	then
		echo "${OLD_GCC_VERSION}" > "${WORKDIR}/.oldgccversion"
	fi

	if [ -n "${OLD_GCC_CHOST}" ]
	then
		if [ "${CHOST}" = "${CCHOST}" -a "${OLD_GCC_CHOST}" != "${CHOST}" ]
		then
			echo "${OLD_GCC_CHOST}" > "${WORKDIR}/.oldgccchost"
		fi
	fi

	# Did we check the version ?
	touch "${WORKDIR}/.chkgccversion"
}

version_patch() {
	[ ! -f "$1" ] && return 1
	[ -z "$2" ] && return 1

	sed -e "s:@GENTOO@:$2:g" ${1} > ${T}/${1##*/}
	epatch ${T}/${1##*/}
}

src_unpack() {
	if [ -z "${SNAPSHOT}" ]
	then
		unpack ${PN}-${GCC_RELEASE_VER}.tar.bz2

		if [ -n "${PATCH_VER}" ]
		then
			unpack ${P}-patches-${PATCH_VER}.tar.bz2
		fi
	else
		unpack gcc-${SNAPSHOT//-}.tar.bz2
	fi

	if [ -n "${PP_VER}" ]
	then
		unpack protector-${PP_FVER}.tar.gz
	fi

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	echo

	# Branch update ...
	if [ -n "${BRANCH_UPDATE}" ]
	then
		epatch ${DISTDIR}/${PN}-${GCC_RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch.bz2
	fi

	# Do bulk patches included in ${P}-patches-${PATCH_VER}.tar.bz2
	if [ -n "${PATCH_VER}" ]
	then
		mkdir -p ${WORKDIR}/patch/exclude

		epatch ${WORKDIR}/patch
	fi

	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		epatch ${FILESDIR}/gcc331_use_multilib.amd64.patch
	fi


	if [ -z "${PP_VER}" ]
	then
		# Make gcc's version info specific to Gentoo
	 	version_patch ${FILESDIR}/3.3.2/gcc332-gentoo-branding.patch \
			"${BRANCH_UPDATE} (Gentoo Linux ${PVR})" || die "Failed Branding"
	fi

	if [ -n "${PP_VER}" ] && [ "${ARCH}" != "hppa" ]
	then
		# ProPolice Stack Smashing protection
		epatch ${WORKDIR}/protector.dif
		cp ${WORKDIR}/protector.c ${WORKDIR}/${P}/gcc/ || die "protector.c not found"
		cp ${WORKDIR}/protector.h ${WORKDIR}/${P}/gcc/ || die "protector.h not found"
		version_patch ${FILESDIR}/3.3.2/gcc332-gentoo-branding.patch \
			"${BRANCH_UPDATE} (Gentoo Linux ${PVR}, propolice)" \
			|| die "Failed Branding"
	fi

	# Install our pre generated manpages if we do not have perl ...
#	if [ ! -x /usr/bin/perl ]
#	then
#		cd ${S}; unpack ${P}-manpages.tar.bz2
#	fi

	# Misdesign in libstdc++ (Redhat)
	cp -a ${S}/libstdc++-v3/config/cpu/i{4,3}86/atomicity.h

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
}

src_compile() {

	local myconf=
	local gcc_lang=

	if ! use build
	then
		myconf="${myconf} --enable-shared"
		gcc_lang="c,c++,f77,objc"
	else
		gcc_lang="c"
	fi
	if ! use nls || use build
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi
	if use java && ! use build
	then
		gcc_lang="${gcc_lang},java"
	fi

	# Enable building of the gcj Java AWT & Swing X11 backend
	# if we have X as a use flag and are not in a build stage.
	# X11 support is still very experimental but enabling it is
	# quite innocuous...  [No, gcc is *not* linked to X11...]
	# <dragon@gentoo.org> (15 May 2003)
	if use java && use X && ! use build && [ -f /usr/X11R6/include/X11/Xlib.h ]
	then
		myconf="${myconf} --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib"
		myconf="${myconf} --enable-interpreter --enable-java-awt=xlib --with-x"
	fi

	# Multilib not yet supported
	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		einfo "WARNING: Multilib support enabled. This is still experimental."
		myconf="${myconf} --enable-multilib"
	else
		if [ "${ARCH}" = "amd64" ]
		then
			einfo "WARNING: Multilib not enabled. You will not be able to build 32bit binaries."
		fi
		myconf="${myconf} --disable-multilib"
	fi

	#Fix linking problem with c++ apps which where linked agains a 3.2.2 libgcc
	[ "${ARCH}" = "hppa" ] && myconf="${myconf} --enable-sjlj-exceptions"

	# Make sure we have sane CFLAGS
	do_filter_flags

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."
	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--includedir=${LIBPATH}/include \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
		--with-system-zlib \
		--enable-languages=${gcc_lang} \
		--enable-threads=posix \
		--enable-long-long \
		--disable-checking \
		--enable-cstdio=stdio \
		--enable-clocale=generic \
		--enable-__cxa_atexit \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	touch ${S}/gcc/c-gperf.h

	# Do not make manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		find ${S} -name '*.[17]' -exec touch {} \; || :
	fi

	einfo "Building GCC..."
	# Only build it static if we are just building the C frontend, else
	# a lot of things break because there are not libstdc++.so ....
	if use static && [ "${gcc_lang}" = "c" ]
	then
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake LDFLAGS="-static" bootstrap \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
		# Above FLAGS optimize and speedup build, thanks
		# to Jeff Garzik <jgarzik@mandrakesoft.com>
	else
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake bootstrap-lean \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die

	fi
}

src_install() {
	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in cd ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
		fi
	done

	einfo "Installing GCC..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make prefix=${LOC} \
		bindir=${BINPATH} \
		includedir=${LIBPATH}/include \
		datadir=${DATAPATH} \
		mandir=${DATAPATH}/man \
		infodir=${DATAPATH}/info \
		DESTDIR="${D}" \
		LIBPATH="${LIBPATH}" \
		install || die

	[ -r ${D}${BINPATH}/gcc ] || die "gcc not found in ${D}"

	dodir /lib /usr/bin
	dodir /etc/env.d/gcc
	echo "PATH=\"${BINPATH}\"" > ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# amd64 is a bit unique because of multilib.  Add some other paths
		echo "LDPATH=\"${LIBPATH}:${LIBPATH}/32:${LIBPATH}/../lib64:${LIBPATH}/../lib32\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	else
		echo "LDPATH=\"${LIBPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	fi
	echo "MANPATH=\"${DATAPATH}/man\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	echo "STDCXX_INCDIR=\"${STDCXX_INCDIR##*/}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	# Also set CC and CXX
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${GCC_RELEASE_VER}

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	if ! use build
	then
		cd ${D}${LIBPATH}

		# Tell libtool files where real libraries are
		for x in ${D}${LOC}/lib/*.la ${D}${LIBPATH}/../*.la
		do
			if [ -f "${x}" ]
			then
				sed -i -e "s:/usr/lib:${LIBPATH}:" ${x}
				mv ${x} ${D}${LIBPATH}
			fi
		done

		# Move all the libraries to version specific libdir.
		for x in ${D}${LOC}/lib/*.{so,a}* ${D}${LIBPATH}/../*.{so,a}*
		do
			[ -f "${x}" -o -L "${x}" ] && mv -f ${x} ${D}${LIBPATH}
		done

		# Move Java headers to compiler-specific dir
		for x in ${D}${LOC}/include/gc*.h ${D}${LOC}/include/j*.h
		do
			[ -f "${x}" ] && mv -f ${x} ${D}${LIBPATH}/include/
		done
		for x in gcj gnu java javax org
		do
			if [ -d "${D}${LOC}/include/${x}" ]
			then
				dodir /${LIBPATH}/include/${x}
				mv -f ${D}${LOC}/include/${x}/* ${D}${LIBPATH}/include/${x}/
				rm -rf ${D}${LOC}/include/${x}
			fi
		done

		if [ -d "${D}${LOC}/lib/security" ]
		then
			dodir /${LIBPATH}/security
			mv -f ${D}${LOC}/lib/security/* ${D}${LIBPATH}/security
			rm -rf ${D}${LOC}/lib/security
		fi

		# Move libgcj.spec to compiler-specific directories
		[ -f "${D}${LOC}/lib/libgcj.spec" ] && \
			mv -f ${D}${LOC}/lib/libgcj.spec ${D}${LIBPATH}/libgcj.spec

		# Rename jar because it could clash with Kaffe's jar if this gcc is
		# primary compiler (aka don't have the -<version> extension)
		cd ${D}${LOC}/${CCHOST}/gcc-bin/${GCC_BRANCH_VER}
		[ -f jar ] && mv -f jar gcj-jar

		# Move <cxxabi.h> to compiler-specific directories
		[ -f "${D}${STDCXX_INCDIR}/cxxabi.h" ] && \
			mv -f ${D}${STDCXX_INCDIR}/cxxabi.h ${D}${LIBPATH}/include/

		# These should be symlinks
		cd ${D}${BINPATH}
		for x in gcc g++ c++ g77 gcj
		do
			rm -f ${CCHOST}-${x}
			[ -f "${x}" ] && ln -sf ${x} ${CCHOST}-${x}

			if [ -f "${CCHOST}-${x}-${PV}" ]
			then
				rm -f ${CCHOST}-${x}-${PV}
				ln -sf ${x} ${CCHOST}-${x}-${PV}
			fi
		done
	fi

	# This one comes with binutils
	if [ -f "${D}${LOC}/lib/libiberty.a" ]
	then
		rm -f ${D}${LOC}/lib/libiberty.a
	fi

	cd ${S}
	if ! use build
	then
		cd ${S}
		docinto /${CCHOST}
		dodoc COPYING COPYING.LIB ChangeLog* FAQ MAINTAINERS README
		docinto ${CCHOST}/html
		dohtml *.html
		cd ${S}/boehm-gc
		docinto ${CCHOST}/boehm-gc
		dodoc ChangeLog doc/{README*,barrett_diagram}
		docinto ${CCHOST}/boehm-gc/html
		dohtml doc/*.html
		cd ${S}/gcc
		docinto ${CCHOST}/gcc
		dodoc ChangeLog* FSFChangeLog* LANGUAGES NEWS ONEWS README* SERVICE
		cd ${S}/libf2c
		docinto ${CCHOST}/libf2c
		dodoc ChangeLog* README TODO *.netlib
		cd ${S}/libffi
		docinto ${CCHOST}/libffi
		dodoc ChangeLog* LICENSE README
		cd ${S}/libiberty
		docinto ${CCHOST}/libiberty
		dodoc ChangeLog* COPYING.LIB README
		cd ${S}/libobjc
		docinto ${CCHOST}/libobjc
		dodoc ChangeLog* README* THREADS*
		cd ${S}/libstdc++-v3
		docinto ${CCHOST}/libstdc++-v3
		dodoc ChangeLog* README
		docinto ${CCHOST}/libstdc++-v3/html
		dohtml -r -a css,diff,html,txt,xml docs/html/*
		cp -f docs/html/17_intro/[A-Z]* \
			${D}/usr/share/doc/${PF}/${DOCDESTTREE}/17_intro/

		if use java
		then
			cd ${S}/fastjar
			docinto ${CCHOST}/fastjar
			dodoc AUTHORS CHANGES COPYING ChangeLog* NEWS README
			cd ${S}/libjava
			docinto ${CCHOST}/libjava
			dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
		fi

		prepman ${DATAPATH}
		prepinfo ${DATAPATH}
	else
		rm -rf ${D}/usr/share/{man,info}
		rm -rf ${D}${DATAPATH}/{man,info}
	fi

	# Rather install the script, else portage with changing $FILESDIR
	# between binary and source package borks things ....
	insinto /lib/rcscripts/awk
	doins ${FILESDIR}/awk/fixlafiles.awk
	exeinto /sbin
	doexe ${FILESDIR}/fix_libtool_files.sh

	# Fix ncurses b0rking
	find ${D}/ -name '*curses.h' -exec rm -f {} \;

	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# If using multilib, GCC has a bug, where it doesn't know where to find
		# -lgcc_s when linking while compiling with g++ .  ${LIBPATH} is in
		# it's path though, so ln the 64bit and 32bit versions of -lgcc_s
		# to that directory.
		ln -sf ${LIBPATH}/../lib64/libgcc_s.so ${D}/${LIBPATH}/libgcc_s.so
		ln -sf ${LIBPATH}/../lib32/libgcc_s_32.so ${D}/${LIBPATH}/libgcc_s_32.so
	fi
}

pkg_preinst() {

	if [ ! -f "${WORKDIR}/.chkgccversion" ]
	then
		chk_gcc_version
	fi

	# Make again sure that the linker "should" be able to locate
	# libstdc++.so ...
	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	${ROOT}/sbin/ldconfig
}

pkg_postinst() {

	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	if [ "${ROOT}" = "/" -a "${CHOST}" = "${CCHOST}" ]
	then
		gcc-config --use-portage-chost ${CCHOST}-${GCC_RELEASE_VER}
	fi

	# Update libtool linker scripts to reference new gcc version ...
	if [ "${ROOT}" = "/" ] && \
	   [ -f "${WORKDIR}/.oldgccversion" -o -f "${WORKDIR}/.oldgccchost" ]
	then
		local OLD_GCC_VERSION=
		local OLD_GCC_CHOST=

		if [ -f "${WORKDIR}/.oldgccversion" ] && \
		   [ -n "$(cat "${WORKDIR}/.oldgccversion")" ]
		then
			OLD_GCC_VERSION="$(cat "${WORKDIR}/.oldgccversion")"
		else
			OLD_GCC_VERSION="${GCC_RELEASE_VER}"
		fi

		if [ -f "${WORKDIR}/.oldgccchost" ] && \
		   [ -n "$(cat "${WORKDIR}/.oldgccchost")" ]
		then
			OLD_GCC_CHOST="--oldarch $(cat "${WORKDIR}/.oldgccchost")"
		fi

		/sbin/fix_libtool_files.sh ${OLD_GCC_VERSION} ${OLD_GCC_CHOST}
	fi

	# Fix ncurses b0rking (if r5 isn't unmerged)
	find ${ROOT}/usr/lib/gcc-lib -name '*curses.h' -exec rm -f {} \;

	# http://dev.gentoo.org/~pappy/hardened-gcc/docs/etdyn-ssp.html
	if has_version '>=sys-devel/hardened-gcc-1.2'
	then
		[ "${ROOT}" = "/" ] && hardened-gcc -A
	fi
}

