# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/privoxy/privoxy-2.9.14_beta.ebuild,v 1.2 2004/08/15 18:35:46 stuart Exp $

inherit eutils

IUSE="selinux"
MY_P=${P/_beta/-beta}
S=${WORKDIR}/${MY_P}
HOMEPAGE="http://www.privoxy.org"
DESCRIPTION="A web proxy with advanced filtering capabilities for protecting privacy against internet junk."
SRC_URI="mirror://sourceforge/ijbswa/${MY_P}-src.tar.gz"

DEPEND="virtual/textbrowser"
RDEPEND="selinux? ( sec-policy/selinux-privoxy )"

SLOT="2"
KEYWORDS="x86 sparc"
LICENSE="GPL-2"

pkg_setup() {
	enewgroup privoxy
	enewuser privoxy -1 /bin/false /etc/privoxy privoxy
}

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/privoxy-gentoo.diff

	cd ${S}
	autoheader || die "autoheader failed"
	autoconf || die "autoconf failed"
}

src_compile() {

	econf \
		--sysconfdir=/etc/privoxy || die "./configure failed"

	emake || die "make failed."

}

src_install () {
	cd ${WORKDIR}/privoxy-2.9.14-beta

	diropts -m 0750 -g privoxy -o privoxy
	dodir /var/log/privoxy
	keepdir /var/log/privoxy
	dodir /etc/privoxy /etc/privoxy/templates

	insopts -m 0640 -g privoxy -o privoxy
	insinto /etc/privoxy
	doins default.filter trust default.action config

	insinto /etc/privoxy/templates
	doins templates/*

	doman privoxy.1

	dodoc LICENSE README AUTHORS doc/text/faq.txt ChangeLog

	insopts
	for i in developer-manual faq man-page user-manual
	do
		insinto /usr/share/doc/${PF}/$i
		doins doc/webserver/$i/*
	done

	insopts -m 0754 -g privoxy -o privoxy
	insinto /etc/init.d
	newins ${FILESDIR}/privoxy.rc6 privoxy

	insopts -m 0750 -g privoxy -o privoxy
	insinto /usr/sbin
	doins privoxy
}
