# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.0.4.ebuild,v 1.1 2001/11/27 08:55:30 jerrya Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${P}-src.tar.gz"
HOMEPAGE="http://www.ncftp.com/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"


src_compile() {
	./configure --prefix=/usr --host=${CHOST} \
		--mandir=/usr/share/man || die
	
	emake || die
}

src_install() {
	dodir /usr/share
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die

	dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
	dodoc READLINE-README README WHATSNEW-3.0
}
