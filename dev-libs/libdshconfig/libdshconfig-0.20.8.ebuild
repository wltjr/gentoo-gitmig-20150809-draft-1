# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdshconfig/libdshconfig-0.20.8.ebuild,v 1.3 2004/03/14 12:28:57 mr_bones_ Exp $

DESCRIPTION="Library for parsing dsh.style configuration files"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"
RDEPEND="virtual/ssh"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
