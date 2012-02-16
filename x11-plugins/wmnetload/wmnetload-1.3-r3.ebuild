# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3-r3.ebuild,v 1.6 2012/02/16 19:13:54 phajdan.jr Exp $

inherit autotools eutils

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=x11-libs/libdockapp-0.6.1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-${PVR}-norpath.patch"

	eautoreconf
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS README NEWS
}
