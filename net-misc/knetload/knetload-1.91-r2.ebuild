# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-1.91-r2.ebuild,v 1.5 2002/07/08 18:06:37 phoenix Exp $

inherit kde-base || die

need-kde 2.1.1

DESCRIPTION="A Network applet for KDE2"
SRC_URI="http://kde.quakenet.eu.org/files/${P}.tar.gz"
HOMEPAGE="http://kde.quakenet.eu.org/knetload.shtml"
LICENSE="GPL-2"
KEYWORDS="x86"

