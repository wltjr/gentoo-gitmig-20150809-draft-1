# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2pdbdoc/txt2pdbdoc-1.4.2.ebuild,v 1.2 2002/07/11 06:30:19 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text to Doc file converter for the Palm Pilot.  Also includes an HTML to Doc converter."
SRC_URI="http://homepage.mac.com/pauljlucas/software/${P}.tar.gz"
HOMEPAGE="http://homepage.mac.com/pauljlucas/software.html"

DEPEND="sys-devel/perl"

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
	dodoc AUTHORS COPYING README INSTALL ChangeLog
}
