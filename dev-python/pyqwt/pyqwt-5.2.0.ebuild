# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyqwt/pyqwt-5.2.0.ebuild,v 1.5 2010/02/28 12:33:09 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit flag-o-matic python

MY_P="PyQwt-${PV}"
DESCRIPTION="Python bindings for the Qwt library"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://pyqwt.sourceforge.net/"

SLOT="5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc examples svg"

RDEPEND=">=x11-libs/qwt-5.1[svg?]
	>=dev-python/PyQt4-4.6.1
	dev-python/numpy"
DEPEND="${DEPEND}
	dev-python/sip"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}/configure"

pkg_setup() {
	append-flags -fPIC
}

src_configure() {
	configuration() {
		# '-j' option can be buggy.
		"$(PYTHON)" configure.py \
			--disable-numarray \
			--disable-numeric \
			-I/usr/include/qwt5 \
			-lqwt || return 1

		# Avoid stripping of the libraries.
		sed -i -e "/strip/d" {iqt5qt4,qwt5qt4}/Makefile || die "sed failed"
	}
	python_execute_function -s configuration

}

src_install() {
	python_src_install

	cd ..
	dodoc ANNOUNCEMENT-${PV} README
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r sphinx/build/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins qt4examples/* || die
	fi
}
