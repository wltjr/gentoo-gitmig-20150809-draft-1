# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-1.2_beta.ebuild,v 1.2 2002/11/18 22:19:33 azarah Exp $

IUSE="mozxmlterm moznomail java mozp3p crypt ipv6 gtk2 mozinterfaceinfo ssl ldap mozaccess mozctl gnome mozsvg"

# NOTE: to build without the mail and news component:  export NO_MAIL="YES"
inherit flag-o-matic gcc makeedit eutils

# Crashes on start when compiled with -fomit-frame-pointer
filter-flags "-fomit-frame-pointer"

EMVER="0.70.0"
IPCVER="1.0.1"

FCVER="2.0"

PATCH_VER="1.0"

# handle _rc versions
MY_PV1="${PV/_}"
MY_PV2="${MY_PV1/eta}"
S="${WORKDIR}/mozilla"
FC_S="${WORKDIR}/fcpackage.${FCVER/\./_}/Xft"
DESCRIPTION="The Mozilla Web Browser"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/${PN}${MY_PV2}/src/${PN}-source-${MY_PV2}.tar.gz
	crypt? ( http://enigmail.mozdev.org/dload/src/enigmail-${EMVER}.tar.gz
	         http://enigmail.mozdev.org/dload/src/ipc-${IPCVER}.tar.gz )
	http://fontconfig.org/release/fcpackage.${FCVER/\./_}.tar.gz"
#	mirror://gentoo/distfiles/${P}-patches-${PATCH_VER}.tar.bz2"
HOMEPAGE="http://www.mozilla.org"

KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

RDEPEND=">=x11-base/xfree-4.2.0-r11
	>=gnome-base/ORBit-0.5.10-r1
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	!gtk2? ( >=media-libs/fontconfig-2.0-r3 )
	>=sys-apps/portage-2.0.14
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	( gtk2? >=x11-libs/gtk+-2.0.5 :
	        =x11-libs/gtk+-1.2* )
	( gtk2? >=dev-libs/glib-2.0.4 :
	        =dev-libs/glib-1.2* )
	java?  ( virtual/jre )"

DEPEND="${RDEPEND}
	virtual/x11
	sys-devel/perl
	java? ( >=dev-java/java-config-0.2.0 )"

# needed by src_compile() and src_install()
export MOZILLA_OFFICIAL=1
export BUILD_OFFICIAL=1

# enable XFT
if [ -z "`use gtk2`" ]; then
	[ "${DISABLE_XFT}" != "1" ] && export MOZ_ENABLE_XFT=1
fi

# make sure the nss module gets build (for NSS support)
[ -n "`use ssl`" ] && export MOZ_PSM=1

# do we build java support for the NSS stuff ?
# NOTE: this is broken for the moment
#[ "`use java`" ] && export NS_USE_JDK=1


src_unpack() {
	
	unpack ${A}

	if [ "$(gcc-major-version)" -eq "3" ] ; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [ "${ARCH}" = "alpha" ] ; then
			cd ${S}; epatch ${FILESDIR}/mozilla-alpha-xpcom-subs-fix.patch
		fi
	fi

	# A patch for mozilla to disregard the PLATFORM variable, which
	# can break compiles (has done for sparc64).  See:
	# http://bugzilla.mozilla.org/show_bug.cgi?id=174143
	cd ${S}; epatch ${FILESDIR}/${PN}-1.0.1-platform.patch

	epatch ${FILESDIR}/1.2/mozilla-1.2b-default-plugin-less-annoying.patch.bz2
	epatch ${FILESDIR}/1.2/mozilla-1.2b-over-the-spot.patch.bz2
	epatch ${FILESDIR}/1.2/mozilla-1.2b-freetype.patch.bz2
	epatch ${FILESDIR}/1.2/mozilla-1.2b-wallet.patch.bz2

	# Get mozilla to link to Xft2.0 that we install in tmp directory
	# <azarah@gentoo.org> (18 Nov 2002)
	if [ -z "`use gtk2`" ]; then
		epatch ${FILESDIR}/1.2/mozilla-1.2b-Xft-includes.patch.bz2
	fi

	if [ -n "`use gtk2`" ]; then
		epatch ${FILESDIR}/1.2/mozilla-1.2b-gtk2.patch.bz2
	fi
	
	cd ${S}
	export WANT_AUTOCONF_2_1=1
	autoconf &> /dev/null
	unset WANT_AUTOCONF_2_1

	# Unpack the enigmail plugin
	if [ -n "`use crypt`" -a -z "`use moznomail`" ] && \
	   [ "${NO_MAIL}" != "YES" -a "${NO_MAIL}" != "yes" ]
	then
		mv ${WORKDIR}/ipc ${S}/extensions/
		mv ${WORKDIR}/enigmail ${S}/extensions/
	fi

	cd ${FC_S}
	export WANT_AUTOCONF_2_5=1
	autoconf --force
	unset WANT_AUTOCONF_2_5
}

src_compile() {

	local myconf=""
	# NOTE: QT and XLIB toolkit seems very unstable, leave disabled until
	#       tested ok -- azarah
	if [ -n "`use gtk2`" ] ; then
		myconf="${myconf} --enable-toolkit-gtk2 \
		                  --enable-default-toolkit=gtk2 \
		                  --disable-toolkit-qt \
		                  --disable-toolkit-xlib \
		                  --disable-toolkit-gtk"
	else
		myconf="${myconf} --enable-toolkit-gtk \
			              --enable-default-toolkit=gtk \
			              --disable-toolkit-qt \
			              --disable-toolkit-xlib \
			              --disable-toolkit-gtk2"
	fi

	if [ -z "`use ldap`" ] ; then
		myconf="${myconf} --disable-ldap"
	fi

	if [ -z "${DEBUG}" ] ; then
		myconf="${myconf} --enable-strip-libs \
			              --disable-debug \
			              --disable-tests \
						  --disable-dtd-debug"
	fi

	if [ -n "${MOZ_ENABLE_XFT}" -a -z "`use gtk2`" ] ; then
		myconf="${myconf} --enable-xft"
	fi

	if [ -n "`use ipv6`" ] ; then
		myconf="${myconf} --enable-ipv6"
	fi


	# NB!!:  Due to the fact that the non default extensions do not always
	#        compile properly, using them is considered unsupported, and
	#        is just here for completeness.  Please do not use if you 
	#        do not know what you are doing!
	#
	# The defaults are (as of 1.0rc1, according to configure (line ~10799)):
	#     cookie wallet content-packs xml-rpc xmlextras help transformiix venkman inspector irc
	# Non-defaults are:
	#     xmlterm access-builtin ctl p3p interfaceinfo
	local myext="default"
	if [ -n "`use mozxmlterm`" ] ; then
		myext="${myext},xmlterm"
	fi
	if [ -n "`use mozaccess-builtin`" ] ; then
		myext="${myext},access-builtin"
	fi
	if [ -n "`use mozctl`" ] ; then
		myext="${myext},ctl"
	fi
	if [ -n "`use mozp3p`" ] ; then
		myext="${myext},p3p"
	fi
	if [ -n "`use mozinterfaceinfo`" ] ; then
		myext="${myext},interfaceinfo"
	fi

	if [ -n "`use mozsvg`" ] ; then
		export MOZ_INTERNAL_LIBART_LGPL="1"
		myconf="${myconf} --enable-svg"
	else
		myconf="${myconf} --disable-svg"
	fi
	
	if [ -n "`use moznomail`" ] || \
	   [ "${NO_MAIL}" = "YES" -o "${NO_MAIL}" = "yes" ]
	then
		myconf="${myconf} --disable-mailnews"
	fi
	
	export BUILD_MODULES=all
	export BUILD_OPT=1

	# Currently gcc-3.1.1 dont work well if we specify "-march"
	# and other optimizations for pentium4.
	if [ "$(gcc-major-version)" -eq "3" ] ; then
		export CFLAGS="${CFLAGS/pentium4/pentium3}"
		export CXXFLAGS="${CXXFLAGS/pentium4/pentium3}"

		# Enable us to use flash, etc plugins compiled with gcc-2.95.3
		if [ "${ARCH}" = "x86" ] ; then
			myconf="${myconf} --enable-old-abi-compat-wrappers"
		fi
	fi

	# *********************************************************************
	#
	#  Configure and build Xft2.0 and Xrender
	#
	# *********************************************************************

	if [ -z "`use gtk2`" ]; then
	
		cd ${FC_S}
		einfo "Configuring Xft2.0..."
		mkdir -p ${WORKDIR}/Xft
		./configure --prefix=${WORKDIR}/Xft || die
	
		einfo "Building Xft2.0..."
		emake || die
	
		einfo "Installing Xft2.0 in temp directory..."
		make prefix=${WORKDIR}/Xft \
			confdir=${WORKDIR}/Xft/etc/fonts \
			datadir=${WORKDIR}/Xft/share \
			install || die

		# We also need to update Xrender ..
		cd ${FC_S}/../Xrender
		einfo "Compiling Xrender..."
		xmkmf
		make
		cp -df Xrender.h extutil.h region.h render.h renderproto.h \
			${WORKDIR}/Xft/include
		cp -df libXrender.so* ${WORKDIR}/Xft/lib

		# Where is Xft2.0 located ?
		export PKG_CONFIG_PATH="${WORKDIR}/Xft/lib/pkgconfig"
	fi

	# *********************************************************************
	#
	#  Configure and build Mozilla
	#
	# *********************************************************************
	
	cd ${S}
	
	#This should enable parallel builds, I hope
	export MAKE="emake"
	
	# Get it to work without warnings on gcc3
	export CXXFLAGS="${CXXFLAGS} -Wno-deprecated"

	./configure --prefix=/usr/lib/mozilla \
		--disable-pedantic \
		--disable-short-wchar \
		--without-mng \
		--disable-xprint \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--with-system-zlib \
		--enable-xsl \
		--enable-crypto \
		--with-java-supplement \
		--with-pthreads \
		--with-extensions="${myext}" \
		--enable-optimize="-O2" \
		--with-default-mozilla-five-home=/usr/lib/mozilla \
		${myconf} || die

	edit_makefiles
	einfo "Building Mozilla..."
	make WORKDIR="${WORKDIR}" || die

	# *********************************************************************
	#
	#  Build Mozilla NSS
	#
	# *********************************************************************

	# Build the NSS/SSL support
	if [ "`use ssl`" ] ; then
		einfo "Building Mozilla NSS..."
		cd ${S}/security/coreconf
		
		# Fix #include problem
		cp headers.mk headers.mk.orig
		echo 'INCLUDES += -I$(DIST)/include/nspr -I$(DIST)/include/dbm'\
			>>headers.mk

		# Disable jobserver here ...
		make MAKE="make" || die

		cd ${S}/security/nss
		
		# Disable jobserver here ...
		make MAKE="make" moz_import || die
		make MAKE="make" || die
		cd ${S}
	fi

	# *********************************************************************
	#
	#  Build Enigmail plugin
	#
	# *********************************************************************

	# Build the enigmail plugin
	if [ -n "`use crypt`" -a -z "`use moznomail`" ] && \
	   [ "${NO_MAIL}" != "YES" -a "${NO_MAIL}" != "yes" ]
	then
		einfo "Building Enigmail plugin..."
		cd ${S}/extensions/ipc
		make || die

		cd ${S}/extensions/enigmail
		make || die
	fi
}

src_install() {

	# Install, don't create tarball
	dodir /usr/lib
	cd ${S}/xpinstall/packager
	einfo "Installing mozilla into build root..."
	make MOZ_PKG_FORMAT="raw" TAR_CREATE_FLAGS="-chf" > /dev/null || die
	mv -f ${S}/dist/mozilla ${D}/usr/lib/mozilla

	if [ -z "`use gtk2`" ]; then
		einfo "Installing Xft2.0..."
		cp -df ${WORKDIR}/Xft/lib/libXft.so.* ${D}/usr/lib/mozilla
		cp -df ${WORKDIR}/Xft/lib/libXrender.so.* ${D}/usr/lib/mozilla
	fi

	einfo "Installing includes and idl files..."
	# Copy the include and idl files
	dodir /usr/lib/mozilla/include/idl /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}/usr/lib/mozilla/include
	cp -LfR idl/* ${D}/usr/lib/mozilla/include/idl
	dosym /usr/lib/mozilla/include /usr/include/mozilla

	# Install the development tools in /usr
	dodir /usr/bin
	mv ${D}/usr/lib/mozilla/{xpcshell,xpidl,xpt_dump,xpt_link} ${D}/usr/bin

	# Install the NSS/SSL libs, headers and tools
	if [ "`use ssl`" ] ; then
		einfo "Installing Mozilla NSS..."
		# Install the headers ('make install' do not work for headers ...)
		insinto /usr/lib/mozilla/include/nss
		doins ${S}/dist/public/seccmd/*.h
		doins ${S}/dist/public/security/*.h

		cd ${S}/security/nss

		mkdir -p ${WORKDIR}/nss/{bin,lib}
		export BUILD_OPT=1
		export SOURCE_BIN_DIR=${WORKDIR}/nss/bin
		export SOURCE_LIB_DIR=${WORKDIR}/nss/lib

		make install || die
		# Gets installed as symbolic links ...
		cp -Lf ${WORKDIR}/nss/bin/* ${D}/usr/bin
		cp -Lf ${WORKDIR}/nss/lib/* ${D}/usr/lib/mozilla

		# Need to unset these incase we want to rebuild, else the build
		# gets newked.
		unset SOURCE_LIB_DIR
		unset SOURCE_BIN_DIR
	fi

	cd ${S}/build/unix
	# Fix mozilla-config and install it
	perl -pi -e "s:/lib/mozilla-${PV}::g" mozilla-config
	perl -pi -e "s:/mozilla-${PV}::g" mozilla-config
	exeinto /usr/lib/mozilla
	doexe mozilla-config
	# Fix pkgconfig files and install them
	insinto /usr/lib/pkgconfig
	for x in *.pc
	do
		if [ -f ${x} ]
		then
			perl -pi -e "s:/lib/mozilla-${PV}::g" ${x}
			perl -pi -e "s:/mozilla-${PV}::g" ${x}
			doins ${x}
		fi
	done

	cd ${S}
	exeinto /usr/bin
	newexe ${FILESDIR}/mozilla.sh mozilla
	# Get mozilla to preload lesstif to fix java bork ...
	if [ "$(gcc-major-version)" -eq "3" ] ; then
		perl -pi -e 's|/usr/lib/mozilla/libc\+\+mem.so|/usr/lib/libXm.so.2|g' \
			${D}/usr/bin/mozilla
	fi
	insinto /etc/env.d
	doins ${FILESDIR}/10mozilla
	dodoc LEGAL LICENSE README/mozilla/README*

	# Fix icons to look the same everywhere
	insinto /usr/lib/mozilla/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		perl -pi -e 's:Comment=Mozilla:Comment=Mozilla Web Browser:' mozilla.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozilla.desktop
	fi

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	einfo "Fixing Permissions..."
	chmod -R g+r,o+r ${D}/usr/lib/mozilla
}

pkg_preinst() {
	# Stale components and chrome files break when unmerging old
	if [ -d ${ROOT}/usr/lib/mozilla/components ] ; then
		rm -rf ${ROOT}/usr/lib/mozilla/components
	fi
	if [ -d ${ROOT}/usr/lib/mozilla/chrome ] ; then
		rm -rf ${ROOT}/usr/lib/mozilla/chrome
	fi

	# Remove stale component registry.
    if [ -e ${ROOT}/usr/lib/component.reg ] ; then
		rm -f ${ROOT}/usr/lib/component.reg
	fi
}

pkg_postinst() {

	export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

	# Make symlink for Java plugin (do not do in src_install(), else it only
	# gets installed every second time)
	if [ "`use java`" -a "$(gcc-major-version)" -ne "3" \
	     -a ! -L ${MOZILLA_FIVE_HOME}/plugins/`java-config --browser-plugin=mozilla` ]
	then
		if [ -e `java-config --full-browser-plugin-path=mozilla` ]
		then
			ln -snf `java-config --full-browser-plugin-path=mozilla` \
				${MOZILLA_FIVE_HOME}/plugins/`java-config --browser-plugin=mozilla` 
		fi
	fi

	# Take care of component registration

	# Remove any stale component.reg
	if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
		rm -f ${MOZILLA_FIVE_HOME}/component.reg
	fi

	# Tempory fix for missing libtimer_gtk.so
	# If it exists when generating component.reg (before unmerge of old),
	# it 'corrupts' the newly generated component.reg with invalid references.
	if [ -e ${MOZILLA_FIVE_HOME}/components/libtimer_gtk.so ] ; then
		rm -f ${MOZILLA_FIVE_HOME}/components/libtimer_gtk.so
	fi

	# Needed to update the run time bindings for REGXPCOM 
	# (do not remove next line!)
	env-update
	# Register components, setup Chrome .rdf files and fix file permissions
	einfo "Registering Components and Chrome..."
	umask 022
	${MOZILLA_FIVE_HOME}/regxpcom &> /dev/null
	if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
		chmod g+r,o+r ${MOZILLA_FIVE_HOME}/component.reg
	fi
	# Setup the default skin and locale to correctly generate the Chrome .rdf files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec rm -f {} \; || :
	echo "skin,install,select,classic/1.0" >> \
		${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt
	echo "locale,install,select,en-US" >> \
		${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt
	${MOZILLA_FIVE_HOME}/regchrome &> /dev/null
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \; || :


	echo
	ewarn "Please unmerge old versions of mozilla, as the header"
	ewarn "layout in /usr/lib/mozilla/include have changed and will"
	ewarn "result in compile errors when compiling programs that need"
	ewarn "mozilla headers and libs (galeon, nautilus, ...)"
}

pkg_postrm() {

	# Regenerate component.reg in case some things changed
	if [ -e ${ROOT}/usr/lib/mozilla/regxpcom ] ; then
	
		export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"
	
		if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
			rm -f ${MOZILLA_FIVE_HOME}/component.reg
		fi

		${MOZILLA_FIVE_HOME}/regxpcom
		if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
			chmod g+r,o+r ${MOZILLA_FIVE_HOME}/component.reg
		fi

		find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec rm -f {} \; || :
		${MOZILLA_FIVE_HOME}/regchrome
		find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \; || :
	fi
}

