# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/relational/relational-0.10.ebuild,v 1.4 2010/04/30 10:57:16 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python distutils eutils

DESCRIPTION="Qt4 relational algebra application"
HOMEPAGE="http://galileo.dmi.unict.it/wiki/relational/"
# upstream url is not static
SRC_URI="http://dev.gentooexperimental.org/~hwoarang/distfiles/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-python/PyQt4[webkit,X]
	media-fonts/dejavu"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_set_active_version 2
}

src_compile() {
	true
}

src_install() {
	insinto "$(python_get_sitedir)/"
	doins -r "${PN}_gui" || die "doins failed"
	doins -r "${PN}" || die "doins failed"
	newbin ${PN}_gui.py ${PN} || die "dobin failed"
	domenu ${PN}.desktop || die "domenu failed"
	dodoc CHANGELOG CREDITS README || die "dodoc failed"
	doman ${PN}.1 || die "doman failed"
}

pkg_postinst() {
	python_mod_optimize ${PN} ${PN}_gui
}

pkg_postrm() {
	python_mod_cleanup ${PN} ${PN}_gui
}
