# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/guarddog/guarddog-1.9.16.ebuild,v 1.1 2003/05/01 11:11:50 mholzer Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="A firewall configuration utility for KDE 3"
SRC_URI="http://www.simonzone.com/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

newdepend ">=net-firewall/iptables-1.2.5"

