# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/vtcl/vtcl-1.6.0.ebuild,v 1.1 2004/08/08 01:09:29 cardoe Exp $

DESCRIPTION="Visual Tcl is a high-quality application development environment."
HOMEPAGE="http://vtcl.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="dev-lang/tk"

MY_DESTDIR=/usr/share/${PN}
src_compile() {
	./configure || die
	sed -i 's,^\(VTCL_HOME=\).*,\1'${MY_DESTDIR}',g' vtcl	|| die "Path fixing failed."
}

src_install() {
	dodir ${MY_DESTDIR} || die "Directory creation failed."
	dobin vtcl || die
	cp -r ./{demo,images,lib,sample,vtcl.tcl} ${D}/${MY_DESTDIR} || die "Data installation failed."
	dodoc ChangeLog LICENSE README
	use doc && dodoc doc/tutorial.txt
	use doc && dohtml doc/*html
}
