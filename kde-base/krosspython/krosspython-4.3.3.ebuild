# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.3.3.ebuild,v 1.2 2009/11/29 15:48:24 ssuominen Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="python/krosspython"
inherit kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-lang/python
"
RDEPEND="${DEPEND}"
