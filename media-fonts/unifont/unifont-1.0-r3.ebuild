# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unifont/unifont-1.0-r3.ebuild,v 1.10 2006/11/26 20:12:57 flameeyes Exp $

inherit eutils

IUSE="X"

DESCRIPTION="X11 GNU unicode font"
HOMEPAGE="http://czyborra.com/"
SRC_URI="mirror://debian/pool/main/u/unifont/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/u/unifont/${P/-/_}-1.diff.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

DEPEND="dev-lang/perl
		|| ( x11-apps/bdftopcf virtual/x11 )
		X? ( || ( x11-apps/mkfontdir virtual/x11 ) )"
RDEPEND=""

FONTPATH="/usr/share/fonts/${PN}"
S="${WORKDIR}/${PN}-dvdeug-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${WORKDIR}/${P/-/_}-1.diff"
}

src_compile() {
	emake || die
	emake -f Makefile.new || die
}

src_install() {
	insinto ${FONTPATH}
	doins unifont*.gz
	use X && mkfontdir ${D}${FONTPATH}
}
