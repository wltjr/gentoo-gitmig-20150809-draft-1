# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xblockout/xblockout-1.1.2.ebuild,v 1.10 2005/02/20 20:31:14 slarti Exp $

inherit games flag-o-matic

DESCRIPTION="XBlockOut: X Window block dropping game in 3 Dimension"
HOMEPAGE="http://www710.univ-lyon1.fr/ftp/xbl/xbl.html"
SRC_URI="ftp://ftp710.univ-lyon1.fr/pub/xbl/xbl-${PV}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="virtual/x11
	virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/xbl-${PV}"

src_unpack() {
	unpack ${A}

	# Don't know about other archs. --slarti
	use amd64 && filter-flags "-fweb"

	sed -i \
		-e "s:-lm:-lm -L/usr/X11R6/lib -lX11:" \
		-e "s:-g$:${CFLAGS}:" ${S}/Makefile.in \
			|| die "sed Makefile.in failed"
}

src_compile() {
	egamesconf || die
	emake \
		SCOREDIR="${GAMES_STATEDIR}/${PN}" \
		GROUP_GID=$(id -g ${GAMES_GROUP}) \
		RESOURCEDIR="${GAMES_DATADIR}/${PN}" \
		|| die "emake failed"
}

src_install() {
	newgamesbin bl xbl || die "newgamesbin failed"
	insinto ${GAMES_DATADIR}/${PN}
	newins Xbl.ad Xbl
	insinto ${GAMES_STATEDIR}/${PN}
	newins Xbl.ad Xbl

	newman xbl.man xbl.6
	dodoc README xbl-README
	dohtml *.html *.gif

	prepgamesdirs
}
