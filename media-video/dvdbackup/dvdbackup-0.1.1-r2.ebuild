# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdbackup/dvdbackup-0.1.1-r2.ebuild,v 1.1 2005/12/18 01:49:40 flameeyes Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Backup content from DVD to hard disk"
HOMEPAGE="http://dvd-create.sourceforge.net/"
SRC_URI="http://dvd-create.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libdvdread"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-debian-FPE.patch"
	epatch "${FILESDIR}/${P}-mkdir.patch"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} -I/usr/include/dvdread \
		-ldvdread -o dvdbackup src/dvdbackup.c \
		|| die "compile failed"
}

src_install() {
	dobin dvdbackup || die
	dodoc README
}
