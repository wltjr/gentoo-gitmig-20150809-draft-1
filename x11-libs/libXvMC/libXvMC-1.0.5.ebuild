# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXvMC/libXvMC-1.0.5.ebuild,v 1.7 2010/01/14 22:49:36 maekke Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org XvMC library"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	x11-proto/videoproto
	x11-proto/xproto"
DEPEND="${RDEPEND}"
PDEPEND="app-admin/eselect-xvmc"
