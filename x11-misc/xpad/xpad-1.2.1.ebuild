# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-1.2.1.ebuild,v 1.3 2002/10/19 22:32:47 cselkirk Exp $

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64 ppc"

DEPEND=">=x11-libs/gtk+-2.0.0"
RDEPEND="${DEPEND}"

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tgz"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc CHANGES COPYING README TODO
}


