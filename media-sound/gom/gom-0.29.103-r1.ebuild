# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gom/gom-0.29.103-r1.ebuild,v 1.17 2007/07/27 14:46:59 drac Exp $

inherit toolchain-funcs

DESCRIPTION="Console Mixer Program for OSS"
HOMEPAGE="http://www.fh-worms.de/~inf222"
SRC_URI="http://www.Fh-Worms.DE./~inf222/code/c/gom/released/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	econf
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS ChangeLog README
	docinto examples
	dodoc README
	docinto examples/default
	dodoc examples/default/*
	docinto examples/two-mixers
	dodoc examples/two-mixers/*
}
