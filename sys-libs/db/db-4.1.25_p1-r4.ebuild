# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-4.1.25_p1-r4.ebuild,v 1.3 2004/06/20 04:54:07 solar Exp $

inherit eutils gnuconfig db

#Number of official patches
PATCHNO=`echo ${PV}|sed -e "s,\(.*_p\)\([0-9]*\),\2,"`
if [ "${PATCHNO}" == "${PV}" ]; then
	MY_PV=${PV}
	MY_P=${P}
	PATCHNO=0
else
	MY_PV=${PV/_p${PATCHNO}}
	MY_P=${PN}-${MY_PV}
fi

S=${WORKDIR}/${MY_P}/build_unix
DESCRIPTION="Berkeley DB"
HOMEPAGE="http://www.sleepycat.com"
SRC_URI="http://www.sleepycat.com/update/snapshot/${MY_P}.tar.gz"
for (( i=1 ; i<=$PATCHNO ; i++ ))
do
	export SRC_URI="${SRC_URI} http://www.sleepycat.com/update/${MY_PV}/patch.${MY_PV}.${i}"
done

LICENSE="DB"
SLOT="4.1"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="tcltk java doc uclibc"

DEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jdk )"

RDEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jre )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${WORKDIR}/${MY_P}
	for (( i=1 ; i<=$PATCHNO ; i++ ))
	do
		patch -p0 <${DISTDIR}/patch.${MY_PV}.${i}
	done
	epatch ${FILESDIR}/${P}-jarlocation.patch

	epatch ${FILESDIR}/${PN}-4.0.14-fix-dep-link.patch
	epatch ${FILESDIR}/${PN}-4.1.25-uclibc.patch
}

src_compile() {
	addwrite /proc/self/maps

	# Mips needs a gnuconfig update so obscure things like mips64 are known
	# db-4.1.25_p1 extracts to ${WORKDIR}/db-4.1.25, so we need to strip the _p1
	if use mips || use uclibc  ; then
		einfo "Updating config.{guess,sub} for mips"
		local OLDS="${S}"
		S="${S}/../dist"
		gnuconfig_update
		S="${OLDS}"
	fi


	use uclibc && local myconf="--disable-rpc" || local myconf="--enable-rpc"

	use amd64 &&  myconf="${myconf} --with-mutex=x86/gcc-assembly"

	use java \
		&& myconf="${myconf} --enable-java" \
		|| myconf="${myconf} --disable-java"

	use tcltk \
		&& myconf="${myconf} --enable-tcl --with-tcl=/usr/lib" \
		|| myconf="${myconf} --disable-tcl"

	if use java && [ -n "${JAVAC}" ]; then
		export PATH=`dirname ${JAVAC}`:${PATH}
		export JAVAC=`basename ${JAVAC}`
	fi

	[ -n "${CBUILD}" ] && myconf="${myconf} --build=${CBUILD}"

	../dist/configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-compat185 \
		--enable-cxx \
		--with-uniquename \
		--host=${CHOST} \
		${myconf} || die

	emake || make || die
}

src_install () {

	einstall || die

	db_src_install_usrbinslot

	db_src_install_headerslot

	db_src_install_doc

	db_src_install_usrlibcleanup

	dodir /usr/sbin
	mv ${D}/usr/bin/berkeley_db_svc ${D}/usr/sbin/berkeley_db41_svc
}

pkg_postinst () {
	db_fix_so
}

pkg_postrm () {
	db_fix_so
}
