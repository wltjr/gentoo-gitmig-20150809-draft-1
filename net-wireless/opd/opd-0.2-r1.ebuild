# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/opd/opd-0.2-r1.ebuild,v 1.1 2005/05/16 18:11:50 ticho Exp $

inherit eutils

MY_PV="v${PV}-2003-03-18"
DESCRIPTION="OBEX Push daemon for BlueZ and IrDA."
HOMEPAGE="http://oss.bdit.de/opd.html"
SRC_URI="http://oss.bdit.de/download/opd-${MY_PV}.tgz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/openobex
	>=net-wireless/bluez-libs-2.10"


S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-compile-fix.patch
	sed -i -e "s| -lsdp||" Makefile
	make || "compilation failed"
}

src_install() {
	dobin opd
	newinitd ${FILESDIR}/${PN}.rc ${PN}
	newconfd ${FILESDIR}/${PN}.conf ${PN}
}

pkg_postinst() {
	echo
	einfo "As there is no documentation included, please read the information on URL:"
	einfo "\t\t${HOMEPAGE}"
	echo
	einfo "You can now configure opd in /etc/conf.d/opd, and run it using"
	einfo " /etc/init.d/opd start"
	echo
}
