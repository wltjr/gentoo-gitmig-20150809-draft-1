# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dominions2-demo-bin/dominions2-demo-bin-2.08.ebuild,v 1.3 2006/02/23 22:25:39 tupone Exp $

inherit games

DESCRIPTION="Dominions 2: The Ascension Wars is an epic turn-based fantasy strategy game"
HOMEPAGE="http://www.shrapnelgames.com/Illwinter/d2/"
SRC_URI="http://www.shrapnelgames.com/downloads/dom2demo_linux_x86.tgz"

RESTRICT="nostrip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="arts esd"

DEPEND="|| ( x11-libs/libXext virtual/x11 )
	virtual/opengl
	virtual/glu
	esd? ( media-sound/esound )
	arts? ( kde-base/arts )"

S="${WORKDIR}/dominions2demo"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	chmod a+x ./dom2demo
}

src_install() {
	dodir "${dir}"
	cp -r "${S}/"* "${Ddir}" || die "cp failed"
	games_make_wrapper dominions2-demo ./dom2demo "${dir}" "${dir}"
	prepgamesdirs
}
