# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-4.0.2.ebuild,v 1.2 2008/04/25 13:20:10 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta
# 4 of 4 tests fail. last tested at 4.0.1.
RESTRICT="test"

DESCRIPTION="KDE: Web browser, file manager, ..."
IUSE="debug htmlhandbook"
KEYWORDS="~amd64 ~x86"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}
	>=kde-base/kfind-${PV}:${SLOT}
	>=kde-base/kurifilter-plugins-${PV}:${SLOT}"

KMEXTRA="apps/doc/${PN}"
KMEXTRACTONLY="apps/lib/konq/"

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
	elog "emerge kde-base/dolphin:kde-4"
	elog
	elog "To use Java on webpages: emerge >=virtual/jre-1.4"
	echo
}
