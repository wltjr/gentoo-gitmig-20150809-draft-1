# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tom von Schwerdtner <tvon@etria.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.0_pre2-r1.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp $

A=${PN}-3.8.0pre2.tar.gz
S=${WORKDIR}/${PN}-3.8.0pre2
DESCRIPTION="Id3 library for C/C++"
SRC_URI="mirror://sourceforge/id3lib/${A}"
HOMEPAGE="http://id3lib.sourceforge.net/"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}

	if [ "`gcc --version | cut -f1 -d.`" -eq 3 ] ||
	   ([ -n "${CXX}" ] && [ "`${CXX} --version | cut -f1 -d.`" -eq 3 ])
	then
		cd ${S}
		# Patch for compilation with gcc-3.0.x thanks to Dirk Jagdmann (doj),
		# and me (fixed the const char** in utils.cpp)
		#
		# Azarah - 5 May 2002
		patch -p1 <${FILESDIR}/${P}-gcc3.patch || die
	fi
}

src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL README THANKS TODO
#	some example programs to be placed in docs dir.
	make clean
	cp -a examples ${D}/usr/share/doc/${PF}/examples
}

