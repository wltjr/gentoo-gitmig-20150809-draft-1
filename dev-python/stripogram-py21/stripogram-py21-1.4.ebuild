# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stripogram-py21/stripogram-py21-1.4.ebuild,v 1.9 2004/06/25 01:51:02 agriffis Exp $

PYTHON_SLOT_VERSION=2.1

inherit distutils
P_NEW="${PN%-py21}-${PV/\./-}"
S=${WORKDIR}/${PN%-py21}

DESCRIPTION="A library for converting HTML to Plain Text."
HOMEPAGE="http://www.zope.org/Members/chrisw/StripOGram/"
SRC_URI="http://www.zope.org/Members/chrisw/StripOGram/${P_NEW}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
