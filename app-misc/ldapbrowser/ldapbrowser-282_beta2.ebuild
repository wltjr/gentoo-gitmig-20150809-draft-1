# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ldapbrowser/ldapbrowser-282_beta2.ebuild,v 1.15 2005/07/20 16:20:46 axxo Exp $

MY_P="Browser282b2"
S=${WORKDIR}/ldapbrowser
DESCRIPTION="Easy management of LDAP directories"
SRC_URI="http://www-unix.mcs.anl.gov/~gawor/ldapcommon/bin/${MY_P}.tar.gz"
HOMEPAGE="http://www.softwareshop.anl.gov/ldapbrowser.html"
IUSE=""
SLOT="0"
LICENSE="Ldap_lic.pdf"
KEYWORDS="x86"

RDEPEND="virtual/x11
	>=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PV}-gentoo.diff
}

src_install() {
	local dirs="lib templates"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	cp -a lbe.jar attributes.config ${D}/opt/${P}/
	dobin lbe.sh
	dosym lbe.sh /usr/bin/ldapbrowser
	dodoc CHANGES.TXT LICENSE.ICONS
	dohtml faq.html readme.html relnotes.html help/*
}
