# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/bsod/bsod-0.1.ebuild,v 1.1 2012/06/15 03:23:09 ssuominen Exp $

EAPI=2
inherit eutils games

DESCRIPTION="This program will let you UNIX user experience the authentic microsoft windows experience"
HOMEPAGE="http://www.vanheusden.com/bsod/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_install() {
	dogamesbin ${PN}
	dodoc Changes

	prepgamesdirs
}
