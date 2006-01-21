# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qvamps/qvamps-0.21.ebuild,v 1.1 2006/01/21 18:15:09 sbriesen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Qt frontend for vamps"
HOMEPAGE="http://vamps.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/swig
	dev-lang/perl
	dev-perl/PerlQt
	>=media-libs/libdvdread-0.9.4"

RDEPEND="${DEPEND}
	>=media-video/dvdauthor-0.6.11
	>=media-video/mjpegtools-1.8.0
	>=media-video/vamps-0.98"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-pipe -O2 -fomit-frame-pointer:\$(MYCFLAGS):g" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" MYCFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make PREFIX="${D}usr" install || die "make install failed"
	dodoc ChangeLog README TODO
}
