# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.2.0.ebuild,v 1.1 2003/02/28 03:02:26 bcowan Exp $

IUSE="ssl"

S=${WORKDIR}/${P}

DESCRIPTION="A Remote Desktop Protocol Client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://rdesktop.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc"

DEPEND="x11-base/xfree 
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {
	local myconf
	
	use ssl \
		&& myconf="--with-openssl=/usr/include/openssl" \
		|| myconf="--without-openssl"
	    
	[ "${DEBUG}" ] && myconf="${myconf} --with-debug"
	
	sed -e "s:-O2:${CFLAGS}:g" Makefile > Makefile.tmp
	mv Makefile.tmp Makefile
	echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
	
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sharedir=/usr/share/${PN} \
		${myconf} || die

	emake || die 
}

src_install () {
	make DESTDIR=${D} install
	
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
