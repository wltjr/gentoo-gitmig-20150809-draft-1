# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/x11fonts-jmk/x11fonts-jmk-3.0-r1.ebuild,v 1.9 2005/07/15 17:22:42 flameeyes Exp $

inherit eutils

MY_P=jmk-x11-fonts-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="This package contains character-cell fonts for use with X."
SRC_URI="http://www.pobox.com/~jmknoble/fonts/${MY_P}.tar.gz"
HOMEPAGE="http://www.jmknoble.net/fonts/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="virtual/x11"
RDEPEND=""

FONTPATH="/usr/share/fonts/jmk"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gzip.patch
}

src_compile() {

	xmkmf || die
	emake || die
}

src_install() {

	make install INSTALL_DIR="${D}${FONTPATH}" || die
	dodoc README NEWS
}
