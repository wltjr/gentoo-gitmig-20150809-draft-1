# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/liboldX/liboldX-1.0.1.ebuild,v 1.1 2005/12/23 08:43:16 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org oldX library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
