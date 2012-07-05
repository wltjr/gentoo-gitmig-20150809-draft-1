# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.82.ebuild,v 1.1 2012/07/05 08:16:54 xmw Exp $

EAPI="4"

inherit autotools eutils fdo-mime vcs-snapshot

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits."
HOMEPAGE="https://github.com/marc-lorber/oregano"
SRC_URI="https://github.com/marc-lorber/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

CDEPEND="dev-libs/libxml2:2
	x11-libs/goocanvas:2.0
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sci-electronics/electronics-menu"

src_prepare() {
	epatch "${FILESDIR}"/${P}-format-security.patch
	epatch "${FILESDIR}"/${P}-remove.unneeded.docs.patch
	eautoreconf
}

src_configure() {
	econf --disable-update-mimedb
}

src_install() {
	emake DESTDIR="${D}" oreganodocdir=/usr/share/doc/${PF} install
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog "You'll need to emerge your prefered simulation backend"
	elog "such ngspice or gnucap for simulation to work."
	elog "As an alternative generate a netlist and use sci-electronics/spice"
	elog "from the command line for simulation."
}
