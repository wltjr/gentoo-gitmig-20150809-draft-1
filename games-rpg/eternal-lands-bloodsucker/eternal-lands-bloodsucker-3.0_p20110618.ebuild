# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-bloodsucker/eternal-lands-bloodsucker-3.0_p20110618.ebuild,v 1.1 2011/06/18 20:41:14 rich0 Exp $

EAPI=2

inherit eutils games

DESCRIPTION="Non-official map pack for Eternal Lands"
HOMEPAGE="http://maps.el-pl.org/"
SRC_URI="http://dev.gentoo.org/~rich0/distfiles/${P}.tar.bz2"
LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"

KEYWORDS="~amd64 ~x86 ~x86-fbsd"

IUSE=""

DEPEND="games-rpg/eternal-lands-data[bloodsuckermaps]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insopts -m 0660
	insinto "${GAMES_DATADIR}/eternal-lands"
	doins -r maps || die "doins failed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Note that the Bloodsucker Maps are not official maps and are not"
	elog "supported by the Eternal Lands team."
	elog "Please do not bother Eternal Lands staff about bugs with the maps."
}
