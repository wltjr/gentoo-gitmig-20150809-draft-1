# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-4.1.3.ebuild,v 1.6 2004/02/13 10:06:01 liquidx Exp $

inherit distutils

DESCRIPTION="Python bindings for BerkelyDB"
HOMEPAGE="http://pybsddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pybsddb/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/python
	=sys-libs/db-4.0*"

DOCS="README.txt TODO.txt"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-db4.0.patch
}

src_compile() {
	distutils_src_compile "--berkeley-db=/usr"
}

src_install() {
	distutils_src_install "--berkeley-db=/usr"
	dohtml docs/*
}

