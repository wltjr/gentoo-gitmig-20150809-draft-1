# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-4.3.3.ebuild,v 1.2 2009/11/29 14:27:40 ssuominen Exp $

EAPI="2"

KMNAME="kdeartwork"
KMMODULE="IconThemes"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!kdeprefix? ( !x11-themes/nuvola )
"
