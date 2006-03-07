# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.1.ebuild,v 1.2 2006/03/07 19:44:07 flameeyes Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="klaptopdaemon - KDE battery monitoring and management for laptops"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( x11-libs/libXtst virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-libs/libX11
			x11-proto/xextproto
			x11-proto/xproto
		) virtual/x11 )
	virtual/os-headers"

# Fix output of klaptopdaemon (kde bug 103437).
PATCHES="${FILESDIR}/kdeutils-3.4.3-klaptopdaemon.patch"
