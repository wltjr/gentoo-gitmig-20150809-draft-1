# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.0-r1.ebuild,v 1.3 2000/09/15 20:09:26 drobbins Exp $

P=gdb-5.0      
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GNU debugger"
SRC_URI="ftp://sourceware.cygnus.com/pub/gdb/releases/${A}"
HOMEPAGE="http://www.gnu.org/software/gdb/gdb.html"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install() {                               
    into /usr

    try make prefix=${D}/usr install install-info
    strip ${D}/usr/bin/*
     prepman
     prepinfo
    # These includes and libs are in binutils already
    rm -f ${D}/usr/lib/libbfd.*
    rm -r ${D}/usr/lib/libiberty.*
    rm -f ${D}/usr/lib/libopcodes.*
    rm -rf ${D}/usr/include
    rmdir ${D}/usr/share

    dodoc COPYING* README
    docinto gdb
    dodoc gdb/CONTRIBUTE gdb/COPYING* gdb/README gdb/MAINTAINERS gdb/NEWS gdb/ChangeLog* gdb/doc/LRS gdb/TODO
}




