# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-vpnclient-3des/cisco-vpnclient-3des-4.0.1a-r1.ebuild,v 1.5 2004/06/24 23:39:31 agriffis Exp $

inherit eutils

MY_PV=${PV/a/.A-k9}
DESCRIPTION="Cisco VPN Client (3DES)"
HOMEPAGE="http://www.cisco.com/en/US/products/sw/secursw/ps2308/index.html"
SRC_URI="vpnclient-linux-${MY_PV}.tar.gz"

LICENSE="cisco-vpn-client"
SLOT="${KV}"
KEYWORDS="-* x86"
RESTRICT="fetch"

DEPEND="virtual/glibc
	virtual/linux-sources
	>=sys-apps/sed-4"

S=${WORKDIR}/vpnclient

VPNDIR=/etc/CiscoSystemsVPNClient

pkg_nofetch() {
	eerror "Please goto:"
	eerror " ${HOMEPAGE}"
	eerror "and download"
	eerror " ${A}"
	eerror "to ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	[ "${KV:0:3}" == "2.6" ] && epatch ${FILESDIR}/${PV}-linux26-gentoo.patch

	# Patch to allow use of alternate CC.  Patch submitted to bug #33488 by
	# Jesse Becker (jbecker@speakeasy.net)
	epatch ${FILESDIR}/driver_build_CC.patch

}

src_compile () {
	check_KV
	sh ./driver_build.sh /lib/modules/${KV}/build
	[ ! -f ./cisco_ipsec ] && die "Failed to make module 'cisco_ipsec'"
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient_init
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient.ini.in
}

src_install() {
	exeinto /etc/init.d
	newexe vpnclient_init vpnclient

	exeinto /usr/bin
	exeopts -m0711
	doexe vpnclient
	exeopts -m4711
	doexe cvpnd
	dobin ipseclog cisco_cert_mgr

	insinto /lib/modules/${KV}/CiscoVPN
	doins cisco_ipsec

	insinto ${VPNDIR}
	newins vpnclient.ini.in vpnclient.ini
	insinto ${VPNDIR}/Profiles
	doins *.pcf
	dodir ${VPNDIR}/Certificates
}

pkg_postinst() {
	einfo  "You must run \`/etc/init.d/vpnclient start\` before using the client."
}
