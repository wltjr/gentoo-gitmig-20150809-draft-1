# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kactivities/kactivities-4.8.1.ebuild,v 1.2 2012/03/23 21:53:33 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Activity Manager"

KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT="test"

# Split out from kdelibs in 4.7.1-r2
add_blocker kdelibs 4.7.1-r1
# Moved here in 4.8
add_blocker activitymanager
