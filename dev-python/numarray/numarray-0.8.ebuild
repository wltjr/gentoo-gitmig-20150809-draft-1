# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numarray/numarray-0.8.ebuild,v 1.4 2004/06/25 01:35:01 agriffis Exp $

inherit distutils

DESCRIPTION="Numarray is an array processing package designed to efficiently manipulate large multi-dimensional arrays"
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/numarray"

DEPEND=">=dev-lang/python-2.2.2"

IUSE=""
SLOT="0"
KEYWORDS="x86"
LICENSE="BSD"
