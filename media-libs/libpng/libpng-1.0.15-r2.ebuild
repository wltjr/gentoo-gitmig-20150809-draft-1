# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.0.15-r2.ebuild,v 1.2 2004/05/14 00:55:39 vapier Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="1.0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.diff

	[ "`gcc-version`" == "3.2" ] && replace-cpu-flags i586 k6 k6-2 k6-3
	[ "`gcc-version`" == "3.3" ] && replace-cpu-flags i586 k6 k6-2 k6-3

	sed \
		-e "s:ZLIBLIB=../zlib:ZLIBLIB=/usr/lib:" \
		-e "s:ZLIBINC=../zlib:ZLIBINC=/usr/include:" \
		-e "s:prefix=/usr:prefix=${D}/usr:" \
		-e "s:-O3:${CFLAGS}:" \
		scripts/makefile.linux > Makefile
}

src_compile() {
	make || die
}

src_install() {
	dodir /usr/{include,lib}
	make install prefix=${D}/usr || die

	newman libpngpf.3 libpngpf-10.3
	newman libpng.3 libpng-10.3
	newman png.5 png-10.5

	# remove stuffs so that libpng-1.2 is the system default
	rm ${D}/usr/lib/pkgconfig/libpng.pc
	rm ${D}/usr/bin/libpng-config
	rm ${D}/usr/lib/libpng.{a,so}
	rm ${D}/usr/include/{png.h,pngconf.h,libpng}
	rm -rf ${D}/usr/man

	dodoc ANNOUNCE CHANGES KNOWNBUG README TODO Y2KINFO
}

pkg_postinst() {
	einfo "Please note:"
	einfo "previous versions of libpng-1.0 series were incorrectly overwriting png.h symlink"
	einfo "and libpng.pc from libpng-1.2.x installation."
	einfo "This might cause removal of png.h by autoclean after you updated libpng-1.0 to 1.0.15"
	einfo ""
	einfo "If you experience problems compiling other packages with error message complaining"
	einfo "about missing png.h, please remerge libpng-1.2.5 manually"
}
