# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# ebuild created by Matthias Schwarzott <zzam@gmx.de>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netpipe/netpipe-1.0.0_beta2.ebuild,v 1.4 2004/06/24 23:59:39 agriffis Exp $

IUSE=""

DESCRIPTION="tool to reliably distribute binary data using UDP broadcasting techniques"

SRC_URI="http://home.t-online.de/home/gerd.o/netpipe.tar.gz"
HOMEPAGE="http://home.t-online.de/home/gerd.o/netpipe.html"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/netpipe"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:^OPT=.*:OPT = ${CFLAGS}:" \
				-e "s:^#CC.*:CC = gcc:" \
				Makefile.orig > Makefile
}

src_compile() {
	make || die
}

src_install () {
	dobin netpipe
	dodoc DOCUMENTATION INSTALL TECH-NOTES
}
