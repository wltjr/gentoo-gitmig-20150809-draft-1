# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qtweetlib/qtweetlib-0.3.ebuild,v 1.2 2012/02/23 18:44:04 johu Exp $

EAPI=4

MY_PN=QTweetLib

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/minimoog/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/minimoog/QTweetLib.git"
	KEYWORDS=""
fi

inherit qt4-r2 cmake-utils ${GIT_ECLASS}

DESCRIPTION="Qt based Twitter library"
HOMEPAGE="https://github.com/minimoog/QTweetLib"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND="
	>=dev-libs/qjson-0.7.1
	>=x11-libs/qt-core-4.6.0[ssl]
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} != *9999* ]]; then
		unpack ${A}
		mv *-${MY_PN}-* "${S}"
	else
		git-2_src_unpack
	fi
}
