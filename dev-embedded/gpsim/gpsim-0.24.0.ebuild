# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.24.0.ebuild,v 1.4 2010/02/17 22:18:23 maekke Exp $

EAPI=2

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://gpsim.sourceforge.net"
SRC_URI="mirror://sourceforge/gpsim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc"

RDEPEND="dev-libs/glib:2
	dev-libs/popt
	>=dev-embedded/gputils-0.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	|| ( dev-util/yacc sys-devel/bison )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-gui
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE AUTHORS ChangeLog HISTORY NEWS \
		PROCESSORS README README.MODULES TODO

	if use doc; then
		insinto /usr/share/doc/${PF}/pdf
		doins "${S}"/doc/gpsim.pdf
	fi
}
