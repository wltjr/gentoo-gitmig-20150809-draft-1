# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4mcs/libxfce4mcs-4.3.99.2.ebuild,v 1.2 2007/01/06 18:52:53 nichoj Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND="~xfce-base/libxfce4util-${PV}
	>=dev-libs/glib-2
	|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto
	virtual/x11 )
	>=x11-libs/gtk+-2.4"

xfce44_core_package
