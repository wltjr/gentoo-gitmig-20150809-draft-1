# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jess/xmms-jess-2.9.1-r1.ebuild,v 1.1 2005/11/12 18:12:08 metalgod Exp $

IUSE=""

inherit eutils

MY_P="JESS-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="JESS Visualization Plugin for XMMS"
SRC_URI="http://arquier.free.fr/${MY_P}.tar.gz"
HOMEPAGE="http://arquier.free.fr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms
	>=media-libs/libsdl-1.1.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fixissues.patch
}

src_install () {
	dodir `xmms-config --visualization-plugin-dir`

	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README NEWS
}
