# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/perltrash/perltrash-0.3.ebuild,v 1.6 2004/06/24 22:28:55 agriffis Exp $

DESCRIPTION="Command-line trash can emulation"
HOMEPAGE="http://www.iq-computing.de/perltrash"
SRC_URI="ftp://www.iq-computing.de/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=dev-lang/perl-5"

src_install() {
	newbin perltrash.pl perltrash
	dodoc COPYING.txt README.txt
}
