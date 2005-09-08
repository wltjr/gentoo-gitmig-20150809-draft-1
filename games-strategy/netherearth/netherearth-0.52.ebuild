# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netherearth/netherearth-0.52.ebuild,v 1.1 2005/09/08 18:27:06 ticho Exp $

inherit eutils games

MY_PV="${PV/./}"
DESCRIPTION="A remake of the SPECTRUM game Nether Earth."
HOMEPAGE="http://braingames.getput.com/nether/"
SRC_URI="http://braingames.getput.com/nether/sources.zip
	http://braingames.getput.com/nether/${PN}${MY_PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.6-r3
	>=media-libs/sdl-mixer-1.2.5-r1
	virtual/glut"

DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/sources

data=../nether\ earth\ v${PV}

src_unpack() {
	DATA_DIR=${GAMES_DATADIR}/${PN}

	unzip -LL "${DISTDIR}/${PN}${MY_PV}.zip" >/dev/null || die "unzip ${PN}${MY_PV} failed"
	unzip -LL "${DISTDIR}/sources.zip" >/dev/null || die "unzip sources.zip failed"
	cd "${S}"
	cp "${FILESDIR}/Makefile" . || die "Makefile copying failed"

	# Fix compilation errors/warnings
	epatch "${FILESDIR}/${P}-linux.patch" || die "epatch failed"

	# Modify dirs and some fopen() permissions
	epatch "${FILESDIR}/${P}-gentoo-paths.patch" || die "epatch failed"
	sed -i \
		-e "s:models:${DATA_DIR}/models:" \
		-e "s:textures:${DATA_DIR}/textures:" \
		-e "s:maps/\*:${DATA_DIR}/maps/\*:" \
		-e "s:\./maps:${DATA_DIR}/maps:" \
		mainmenu.cpp || die "sed mainmenu.cpp failed"
	sed -i \
		-e "s:models:${DATA_DIR}/models:g" \
		-e "s:textures:${DATA_DIR}/textures:" \
		-e "s:sound/:${DATA_DIR}/sound/:" \
		nether.cpp || die "sed nether.cpp failed"
	sed -i -e "s:maps:${DATA_DIR}/maps:" \
		main.cpp || die "sed main.cpp failed"
	sed -i -e "s:textures/:${DATA_DIR}/textures/:" \
		myglutaux.cpp || die "sed myglutaux.cpp failed"

	cd "${data}"
	rm textures/thumbs.db
}

src_install() {
	dogamesbin nether_earth

	cd "${data}"

	# Install all game data
	insinto "${DATA_DIR}"
	doins -r maps models sound textures

	dodoc readme.txt

	prepgamesdirs
}
