# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mkxf86config/mkxf86config-0.8-r2.ebuild,v 1.4 2004/06/26 00:36:44 jhuebel Exp $

inherit eutils

IUSE="livecd"

MY_PN="xf86config-knoppix"
MY_PV="${PV}-5"
MY_P="${MY_PN}_${MY_PV}"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="xf86config setup program"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${MY_P}.tar.gz"
HOMEPAGE="http://www.knopper.net"

KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
RDEPEND="sys-apps/hwsetup
	sys-apps/ddcxinfo-knoppix
	virtual/glibc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_install() {
	dodoc debian/README.Debian debian/changelog debian/control debian/copyright
	insinto /etc/X11
	doins XF86Config-4.in XF86Config.in
	exeinto /usr/sbin
	doexe mkxf86config.sh

	if use livecd; then
		exeinto /etc/init.d
		newexe ${FILESDIR}/mkxf86config-init mkxf86config
	fi
}
