# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/kfilereplace/kfilereplace-0.6.1.ebuild,v 1.6 2002/08/02 17:42:49 phoenix Exp $

inherit kde-base || die

need-kde 2.1.1

DESCRIPTION="A multifile replace utility"
SRC_URI="http://download.sourceforge.net/kfilereplace/${P}.tar.bz2"
HOMEPAGE="http://kfilereplace.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="$DEPEND sys-devel/perl"


