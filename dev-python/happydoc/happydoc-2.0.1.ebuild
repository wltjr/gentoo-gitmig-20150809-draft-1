# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-2.0.1.ebuild,v 1.10 2003/02/13 11:34:42 vapier Exp $

# HappyDoc version numbering is not very compatible with portage -- kludgeing
S=${WORKDIR}/HappyDoc-r2_0_1/

DESCRIPTION="HappyDoc is a tool for extracting documentation from Python sourcecode."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/happydoc/HappyDoc_r2_0_1.tar.gz"
HOMEPAGE="http://happydoc.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc alpha"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc INSTALL.txt LICENSE.txt CHANGES.txt README.txt test_happydoc.py
	dohtml -r srcdocs/*
}
