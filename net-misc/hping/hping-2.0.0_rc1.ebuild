# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/hping/hping-2.0.0_rc1.ebuild,v 1.1 2001/11/20 02:13:15 blocke Exp $

# NOTE: author couldn't make up mind over tarball names, directory names,
# etc... hense the need to hardcode S and SRC_URI :(
S=${WORKDIR}/hping2
DESCRIPTION="hping is a command-line oriented TCP/IP packet assembler/analyzer whose interface is inspired by the unix ping command"
SRC_URI="http://www.hping.org/hping2.0.0-rc1.tar.gz"
HOMEPAGE="http://www.hping.org"

DEPEND="net-libs/libpcap"

src_compile() {
    cd ${S}

    ./configure || die
    make CCOPT="$CFLAGS" || die
    make strip
}

src_install () {
    cd ${S}

    dodir /usr/sbin
    dosbin hping2
    dosym /usr/sbin/hping2 /usr/sbin/hping

    doman docs/hping2.8	
    dodoc INSTALL KNOWN-BUGS MIRRORS NEWS README TODO AUTHORS BUGS CHANGES COPYING

}
