# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-990821.ebuild,v 1.18 2004/06/25 00:07:54 agriffis Exp $

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://www.freshmeat.net/projects/rdate/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=""

src_compile() {
	make || die
}

src_install() {
	dodir /usr/bin /usr/share /usr/share/man/man1
	make DESTDIR=${D} install || die
	dodoc README.linux
}
