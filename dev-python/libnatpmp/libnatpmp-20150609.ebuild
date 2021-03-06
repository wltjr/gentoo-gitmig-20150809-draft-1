# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libnatpmp/libnatpmp-20150609.ebuild,v 1.1 2015/07/03 12:31:14 blueness Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="Python module for libnatpmp, an alternative protocol to UPnP IGD"
HOMEPAGE="http://miniupnp.free.fr/libnatpmp.html"
SRC_URI="http://miniupnp.free.fr/files/download.php?file=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~net-libs/${P}"
RDEPEND="${DEPEND}"

python_prepare_all() {
	epatch "${FILESDIR}"/link-against-system-lib.patch

	#These are installed by net-libs/libnatpmp
	rm -f Changelog.txt README || die
	distutils-r1_python_prepare_all
}
