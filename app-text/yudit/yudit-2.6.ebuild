# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/yudit/yudit-2.6.ebuild,v 1.2 2002/07/11 06:30:19 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Yudit is a free (Y)unicode text editor for all unices"

SRC_URI="http://yudit.org/download/${P}.tar.gz"

HOMEPAGE="http://www.yudit.org"

LICENSE="GPL-2"

DEPEND="virtual/x11 
	>=sys-devel/gettext-0.10"
RDEPEND=

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
