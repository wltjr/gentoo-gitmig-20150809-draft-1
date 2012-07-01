# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grive/grive-0.2_pre20120628.ebuild,v 1.2 2012/07/01 17:45:56 ago Exp $

EAPI=4

inherit cmake-utils eutils multilib

if [ "${PV}" != "9999" ]; then
	SRC_URI="http://dev.gentoo.org/~ottxor/distfiles/${P}.tar.gz"
else
	SRC_URI=""
	inherit git-2
	EGIT_REPO_URI="git://github.com/Grive/${PN}.git"
fi

DESCRIPTION="an open source Linux client for Google Drive"
HOMEPAGE="http://www.lbreda.com/grive/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/boost:1.48
	dev-libs/expat
	dev-libs/json-c
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	net-misc/curl
	sys-devel/binutils
	sys-libs/glibc
	sys-libs/zlib
	"

DEPEND="${RDEPEND}"

DOCS=( "README" )
