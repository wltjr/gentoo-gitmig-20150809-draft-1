# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oct2py/oct2py-0.3.2.ebuild,v 1.2 2012/08/01 21:47:50 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
DISTUTILS_SRC_TEST="nosetests"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-*"

inherit distutils

DESCRIPTION="Python to GNU Octave bridge"
HOMEPAGE="http://pypi.python.org/pypi/oct2py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="sci-libs/scipy
	sci-mathematics/octave"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

src_compile() {
	distutils_src_compile
	if use doc; then
		PYTHONPATH=build-"$(PYTHON -f --ABI)"/lib sphinx-build doc html || die
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r example/*
	fi
}
