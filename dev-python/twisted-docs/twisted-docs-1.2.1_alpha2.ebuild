# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-docs/twisted-docs-1.2.1_alpha2.ebuild,v 1.2 2004/06/25 01:51:43 agriffis Exp $

#inherit distutils

MY_PN="TwistedDocs"
# for alphas,.. 
MY_PV="${PV/_alpha/alpha}"
DESCRIPTION="collection of servers and clients, which can be used either by developers of new applications or directly. Documentation included."
HOMEPAGE="http://www.twistedmatrix.com/"
SRC_URI="http://twisted.sourceforge.net/${MY_PN}-${MY_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_PN}-${MY_PV}

src_unpack() {
	unpack ${MY_PN}-${MY_PV}.tar.bz2
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	cd ${S}
	# of course it's documentation!
	doman man/*.[0-9n]
	rm -rf man	# don't dupe the man pages

	dodir /usr/share/doc/${PF}
	cp -r . ${D}/usr/share/doc/${PF}
}
