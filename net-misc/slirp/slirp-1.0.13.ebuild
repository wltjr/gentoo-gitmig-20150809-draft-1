# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/slirp/slirp-1.0.13.ebuild,v 1.11 2004/06/25 00:11:46 agriffis Exp $

DESCRIPTION="Emulates a PPP or SLIP connection over a terminal"
HOMEPAGE="http://slirp.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/slirp/${P}.tar.gz"

KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="slirp"

DEPEND="virtual/glibc"

src_compile() {
	cd src
	./configure || die
	make || die
}

src_install() {
	dobin src/slirp
	cp src/slirp.man slirp.1
	doman slirp.1
	dodoc docs/* README.NEXT README ChangeLog COPYRIGHT
}
