# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclamav/pyclamav-0.1.ebuild,v 1.3 2004/06/25 01:38:07 agriffis Exp $

inherit distutils

DESCRIPTION="Python binding for libclamav"
HOMEPAGE="http://norman.free.fr/norman/python/pyclamav/"
SRC_URI="http://norman.free.fr/norman/python/pyclamav/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
DEPEND=">=virtual/python-2.1
	>=app-antivirus/clamav-0.70"
SLOT="0"
IUSE=""

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF} && doins example.py
}
