# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/soliduiserver/soliduiserver-4.3.3.ebuild,v 1.2 2009/11/29 16:47:35 ssuominen Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE4: Soliduiserver"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep solid)
"
RDEPEND="${DEPEND}"
