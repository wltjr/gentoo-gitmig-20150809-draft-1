# Copyright 1999-2005 Gentoo Foundation and Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/koth/koth-0.8.0.ebuild,v 1.12 2005/05/31 08:00:18 cryos Exp $

inherit eutils games

DESCRIPTION="Multiplayer, networked game of little tanks with really big weapons"
HOMEPAGE="http://www.nongnu.org/koth/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/default.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libggi"

src_unpack(){
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/koth-0.8.0-gcc-3.4.patch
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto /etc/koth
	doins src/koth.cfg
	dodoc AUTHORS ChangeLog INSTALL NEWS README doc/*.txt
	prepgamesdirs
}
