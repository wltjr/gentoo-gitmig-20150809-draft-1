# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vde/vde-1.5.8.ebuild,v 1.2 2005/06/09 22:34:46 rphillips Exp $

DESCRIPTION="vde is a virtual distributed ethernet emulator for emulators like qemu, bochs, and uml."
SRC_URI="mirror://sourceforge/vde/${P}.tgz"
HOMEPAGE="http://vde.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

inherit eutils

src_compile() {
	pushd qemu
	epatch ${FILESDIR}/vde-qemu-Makefile.in.diff
	popd
	econf
	emake
}

src_install() {
	einstall

	dodir /etc/init.d
	cp ${FILESDIR}/vde.init.d ${D}/etc/init.d/vde
	fperms a+x ${D}/etc/init.d/vde

	dodoc COPYING INSTALL PORTS README
}


