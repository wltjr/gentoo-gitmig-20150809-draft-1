# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.94-r2.ebuild,v 1.6 2004/07/15 00:06:09 agriffis Exp $

inherit python distutils

DESCRIPTION="Extensible python-based build utility"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~mips amd64 ~ia64"
IUSE=""

DEPEND=">=dev-lang/python-2.0"

DOCS="RELEASE.txt CHANGES.txt LICENSE.txt"

src_install () {
	distutils_src_install
	doman scons.1 sconsign.1
}

pkg_postinst() {
	python_mod_optimize /usr/lib/scons/SCons
}

pkg_postrm() {
	python_mod_cleanup
}
