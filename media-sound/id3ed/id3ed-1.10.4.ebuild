# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3ed/id3ed-1.10.4.ebuild,v 1.14 2005/11/07 11:06:11 flameeyes Exp $

IUSE=""

DESCRIPTION="ID3 tag editor for mp3 files"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/id3ed.html"
SRC_URI="http://www.azstarnet.com/~donut/programs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ~ppc64"

DEPEND="sys-libs/ncurses
	sys-libs/readline"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS} -I./" || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	einstall || die

	dodoc README ChangeLog
}
