# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-nsc/xf86-video-nsc-2.7.6.3.ebuild,v 1.1 2005/12/04 23:10:32 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for nsc cards"
KEYWORDS="~x86"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/xproto"
