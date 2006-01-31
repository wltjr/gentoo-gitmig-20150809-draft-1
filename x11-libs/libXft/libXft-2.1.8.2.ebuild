# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXft/libXft-2.1.8.2.ebuild,v 1.4 2006/01/31 13:31:04 killerfox Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xft library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	media-libs/freetype
	>=media-libs/fontconfig-2.2"
DEPEND="${RDEPEND}"

PROVIDE="virtual/xft"
