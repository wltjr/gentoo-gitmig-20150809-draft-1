# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/addresses/addresses-0.4.6-r1.ebuild,v 1.3 2005/08/07 13:33:13 hansmi Exp $

inherit gnustep eutils

S=${WORKDIR}/${P/a/A}

DESCRIPTION="Addresses is a Apple Addressbook work alike (standalone and for GNUMail)"
HOMEPAGE="http://giesler.biz/bjoern/en/sw_addr.html"
#SRC_URI="mirror://gentoo/${P/a/A}.tar.gz"
#SRC_URI="http://dev.gentoo.org/~fafhrd/gnustep/apps/${P/a/A}.tar.gz"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/contrib/${P/a/A}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc x86"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"

src_unpack() {
	egnustep_env
	unpack ${A}
	cd ${S}
	if [ -z "${GNUSTEP_FLATTENED}" ]; then
		epatch ${FILESDIR}/nonflattened.patch
	fi
	epatch ${FILESDIR}/address-user-root.patch
}

