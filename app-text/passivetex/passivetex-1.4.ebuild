# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/passivetex/passivetex-1.4.ebuild,v 1.4 2002/07/11 06:30:19 drobbins Exp $

S=${WORKDIR}/passivetex
DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="http://users.ox.ac.uk/~rahtz/passivetex/${PN}.zip"
HOMEPAGE="http://users.ox.ac.uk/~rahtz/passivetex/"

DEPEND="app-text/tetex app-arch/unzip
	app-text/xmltex"
RDEPEND="app-text/tetex
	app-text/xmltex"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	cp ${FILESDIR}/${P}-Makefile Makefile
}

src_compile() {
	make || die
}

src_install () {

	make DESTDIR=${D} install || die

}

pkg_postinst() {
  if [ -e /usr/bin/mktexlsr ]
  then
	/usr/bin/mktexlsr
  fi
}
