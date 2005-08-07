# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knetscan/knetscan-1.0.ebuild,v 1.11 2005/08/07 13:02:35 hansmi Exp $

inherit kde

DESCRIPTION="KDE frontend for nmap, ping, whois and traceroute"
HOMEPAGE="http://sourceforge.net/projects/knetscan"
SRC_URI="mirror://sourceforge/knetscan/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=net-analyzer/nmap-2.54_beta36
	>=net-analyzer/traceroute-1.4_p12
	>=net-misc/whois-4.5.28-r1
	>=sys-apps/netkit-base-0.17-r5"

need-kde 3

