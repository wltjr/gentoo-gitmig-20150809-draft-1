# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzor/pyzor-0.4.0.ebuild,v 1.3 2003/02/13 11:39:07 vapier Exp $

DESCRIPTION="Pyzor is a distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://pyzor.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyzor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/python
	sys-libs/gdbm"
RDEPEND=${DEPEND}

inherit distutils

src_install () {
	mydoc="INSTALL NEWS PKG-INFO THANKS UPGRADING"
	distutils_src_install
	dohtml docs/usage.html

	rm -rf ${D}/usr/share/doc/pyzor
}
