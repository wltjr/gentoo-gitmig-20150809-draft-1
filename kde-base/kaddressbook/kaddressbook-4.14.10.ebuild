# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook/kaddressbook-4.14.10.ebuild,v 1.1 2015/07/11 11:49:27 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
EGIT_BRANCH="KDE/4.14"
inherit kde4-meta

DESCRIPTION="The KDE Address Book"
HOMEPAGE="http://www.kde.org/applications/office/kaddressbook/"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'akonadi(+)')
	$(add_kdebase_dep kdepim-common-libs)
	dev-libs/grantlee:0
	!kde-base/contactthemeeditor
"
RDEPEND="${DEPEND}"

KMEXTRA="
	grantleeeditor/contactthemeeditor
	plugins/kaddressbook/
	plugins/ktexteditor/
"
KMCOMPILEONLY="
	grantleetheme/
	kaddressbookgrantlee/
"
KMEXTRACTONLY="
	akonadi_next/
	calendarsupport/
	grantleeeditor/grantleethemeeditor/
	libkleo/
	pimcommon/
"

KMLOADLIBS="kdepim-common-libs"

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}
