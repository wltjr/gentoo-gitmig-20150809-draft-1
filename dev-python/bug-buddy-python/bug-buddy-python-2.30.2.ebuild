# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bug-buddy-python/bug-buddy-python-2.30.2.ebuild,v 1.8 2011/03/18 09:18:36 nirbheek Exp $

EAPI="2"

GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="bugbuddy"

inherit gnome-python-common

DESCRIPTION="Python bindings for Bug Buddy"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-extra/bug-buddy-2.16:2
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
