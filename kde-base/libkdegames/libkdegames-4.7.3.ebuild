# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.7.3.ebuild,v 1.3 2011/12/07 22:13:47 hwoarang Exp $

EAPI=4

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=dev-games/ggz-client-libs-0.0.14
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

PATCHES=(
	"${FILESDIR}"/${PN}-4.2.0-darwin.patch
)
