# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/xmltex/xmltex-1.0.ebuild,v 1.1 2001/03/17 22:40:54 achim Exp $

#P=
A=base.tar.gz
S=${WORKDIR}/base
DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="ftp://ftp.tex.ac.uk/tex-archive/macros/xmltex/${A}"
HOMEPAGE="http://users.ox.ac.uk/~rahtz/passivetex/"

DEPEND="app-text/tetex"

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${FILESDIR}/${P}-Makefile Makefile
}

src_compile() {
    try make
}

src_install () {

    try make DESTDIR=${D} install
    cd ${D}/usr/bin
    ln -sf virtex xmltext
    ln -sf pdfvirtex pdfxmltex
}

pkg_postinst() {
  if [ -e /usr/bin/mktexlsr ]
  then
    /usr/bin/mktexlsr
  fi
}
