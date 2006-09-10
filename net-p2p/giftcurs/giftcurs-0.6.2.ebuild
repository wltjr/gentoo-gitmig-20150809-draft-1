# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftcurs/giftcurs-0.6.2.ebuild,v 1.10 2006/09/10 16:45:05 the_paya Exp $

MY_P="giFTcurs-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A ncurses frontend to the giFT daemon"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/giftcurs/"
SLOT="0"
LICENSE="GPL-2"
IUSE="gpm nls unicode"
KEYWORDS="~alpha amd64 ~ppc sparc x86 ~x86-fbsd"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	>=dev-libs/glib-2.0"

src_compile() {
	local myconf=""

	use gpm || myconf="${myconf} --disable-mouse --disable-libgpm"
	use nls || myconf="${myconf} --disable-nls"
	use unicode && myconf="${myconf} --with-ncursesw"

	econf $myconf || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog NEWS README THANKS TODO
}
