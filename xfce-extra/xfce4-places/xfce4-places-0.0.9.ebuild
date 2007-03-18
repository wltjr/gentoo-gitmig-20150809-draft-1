# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-places/xfce4-places-0.0.9.ebuild,v 1.5 2007/03/18 21:28:28 vapier Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Rewrite of GNOME Places menu for panel"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="debug"
RESTRICT="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
