# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbatt/xbatt-1.2.1.ebuild,v 1.3 2004/06/14 18:33:17 pyrania Exp $

DESCRIPTION="Notebook battery indicataor for X"
SRC_URI="http://www.clave.gr.jp/~eto/xbatt/${P}.tar.gz"
HOMEPAGE="http://www.clave.gr.jp/~eto/xbatt/"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make xbatt || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README* COPYRIGHT
}
