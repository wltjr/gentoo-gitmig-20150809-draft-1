# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrfc3339/pyrfc3339-0.2.ebuild,v 1.1 2015/08/08 13:43:28 mrueg Exp $

EAPI=5
PYTHON_COMPAT=(python{2_7,3_3,3_4})

inherit distutils-r1
MY_PN=pyRFC3339

MY_P=${MY_PN}-${PV}
DESCRIPTION="Generates and parses RFC 3339 timestamps"
HOMEPAGE="https://github.com/kurtraschke/pyRFC3339"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}

PATCHES=("${FILESDIR}"/${P}-fixdoctests.patch)

python_test() {
	nosetests || die
}
