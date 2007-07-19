# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.3.ebuild,v 1.1 2007/07/19 21:28:51 drac Exp $

inherit toolchain-funcs

DESCRIPTION="ncurses analog clock"
HOMEPAGE="http://www.soomka.com"
SRC_URI="http://www.soomka.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_compile() {
	$(tc-getCXX) ${CXXFLAGS} -Wall -o clockywock clockywock.cpp -lncurses -lpthread || die "build failed."
}

src_install() {
	dobin clockywock
	dodoc README
}
