# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/simgear/simgear-0.3.1.ebuild,v 1.4 2003/02/09 22:34:11 seemant Exp $

MY_P=SimGear-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://simgear/Source/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="X gnome"

DEPEND=">=media-libs/plib-1.6.0
	dev-db/metakit
	media-libs/glut"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc README* NEWS AUTHORS ChangeLog
}
