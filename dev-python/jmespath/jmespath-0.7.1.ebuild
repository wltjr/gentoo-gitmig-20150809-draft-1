# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jmespath/jmespath-0.7.1.ebuild,v 1.2 2015/07/06 04:42:55 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="JSON Matching Expressions"
HOMEPAGE="https://github.com/boto/jmespath https://pypi.python.org/pypi/jmespath"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"
RDEPEND=""

python_test() {
	nosetests || die
}
