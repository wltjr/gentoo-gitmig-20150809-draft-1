# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-2.54_beta31.ebuild,v 1.1 2002/03/21 16:45:30 seemant Exp $

#MY_P="nmap-2.54BETA31"
MY_P="${P/_beta/BETA}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Portscanner"
SRC_URI="http://www.insecure.org/nmap/dist/${MY_P}.tgz"
HOMEPAGE="http://www.insecure.org/nmap/"
DEPEND="virtual/glibc
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )"

src_compile() {                           
	./configure	\
		--host=${CHOST}	\
		--prefix=/usr	\
		--mandir=/usr/share/man	\
		--enable-ipv6	\
		|| die

	if [ "`use gtk`" ] ; then
		make || die
	else
		make nmap || die
	fi
}

src_install() {                               

  make	\
  	prefix=${D}/usr 	\
	mandir=${D}/usr/share/man	\
	install

  dodoc CHANGELOG COPYING HACKING README*
  cd docs
  dodoc *.txt
  dohtml *.html
}
