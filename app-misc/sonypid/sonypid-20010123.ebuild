# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-20010123.ebuild,v 1.2 2002/07/11 06:30:16 drobbins Exp $


DESCRIPTION="sonypid - a tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://www.alcove-labs.org/en/software/sonypi/"
LICENSE="GPL"
DEPEND=""
RDEPEND=${DEPEND}
SRC_URI="http://download.alcove-labs.org/software/sonypi/sonypid.tar.bz2"
S=${WORKDIR}/sonypid
SLOT="0"

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -Wstrict-prototypes -I/usr/src/linux/include" || die
}

src_install () {
    dobin sonypid
}
