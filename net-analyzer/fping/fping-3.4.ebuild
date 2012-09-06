# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-3.4.ebuild,v 1.2 2012/09/06 01:34:15 blueness Exp $

EAPI=4

DESCRIPTION="A utility to ping multiple hosts at once"
HOMEPAGE="http://fping.org/"
SRC_URI="http://fping.org/dist/${P}.tar.gz"

LICENSE="fping"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ipv6 suid"

src_configure() {
	econf $(use_enable ipv6)
}

src_install() {
	default

	if use suid ; then
		fperms u+s /usr/sbin/fping
		use ipv6 && fperms u+s /usr/sbin/fping6
	fi
}
