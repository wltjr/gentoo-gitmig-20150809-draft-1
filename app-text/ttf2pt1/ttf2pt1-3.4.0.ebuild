# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ttf2pt1/ttf2pt1-3.4.0.ebuild,v 1.19 2004/07/14 00:49:03 agriffis Exp $

inherit eutils

DESCRIPTION="Converts True Type to Type 1 fonts"
HOMEPAGE="http://ttf2pt1.sourceforge.net/"
SRC_URI="mirror://sourceforge/ttf2pt1/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

RDEPEND="virtual/libc
	>=media-libs/freetype-2.0"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-Makefile-gentoo.diff
}

src_compile() {
	make CFLAGS="${CFLAGS}" all || die
}

src_install() {
	make INSTDIR=${D}/usr install || die
	dodir /usr/share/doc/${PF}/html
	cd ${D}/usr/share/ttf2pt1
	rm -r app other
	mv *.html ../doc/${PF}/html
	mv [A-Z]* ../doc/${PF}
	prepalldocs
}
