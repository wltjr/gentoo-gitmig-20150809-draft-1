# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdriinfo/xdriinfo-1.0.0-r1.ebuild,v 1.3 2006/03/19 18:25:57 nixnut Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xdriinfo application"
KEYWORDS="~ppc ~ppc64 ~x86"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/glproto"

PATCHES="${FILESDIR}/nvidia-glx-fix.patch"
