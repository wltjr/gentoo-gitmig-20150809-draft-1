# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xpaint/xpaint-2.6.9.ebuild,v 1.7 2004/07/14 18:33:55 agriffis Exp $

DESCRIPTION="XPaint is an image editor which supports most standard paint program options."
SRC_URI="mirror://sourceforge/sf-xpaint/${P}.tar.bz2"
HOMEPAGE="http://sf-xpaint.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/tiff-3.2
	virtual/x11
	media-libs/jpeg
	media-libs/libpng"

src_compile() {
	xmkmf -a || die
	# It demands Xaw95 libs now even if the docs
	# say somthing else (own version is included)
	make xaw95static || die
}

src_install() {
	# make install causes tons of sanbox violations
	# even if it uses DESTDIR so we do it the hard way

	insinto /etc/X11/app-defaults
	doins app-defaults/out/*

	dobin xpaint

	insinto /usr/share/xpaint/help
	doins share/help/*
	insinto /usr/share/xpaint/messages
	doins share/messages/*
	insinto /usr/share/xpaint/filters
	doins share/filters/*
	insinto /usr/share/xpaint/include
	doins image.h

	insinto /usr/share/pixmaps
	doins XPaintIcon.xpm

	newman xpaint._man xpaint.1

	dodoc ChangeLog INSTALL README README.PNG README.old TODO \
	      Doc/Operator.doc Doc/sample.Xdefaults
}
