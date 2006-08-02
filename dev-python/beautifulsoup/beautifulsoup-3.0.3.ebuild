# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup/beautifulsoup-3.0.3.ebuild,v 1.2 2006/08/02 03:35:39 tgall Exp $

inherit distutils

MY_P=${P/beautifulsoup/BeautifulSoup}
S=${WORKDIR}/${MY_P}

DESCRIPTION="HTML/XML parser for quick-turnaround applications like screen-scraping."
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/"
SRC_URI="http://www.crummy.com/software/BeautifulSoup/download/${MY_P}.tar.gz"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}"


src_test() {
	"${python}" BeautifulSoupTests.py || die "tests failed"
}
