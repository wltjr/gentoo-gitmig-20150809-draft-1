# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mouseemu/mouseemu-0.12.ebuild,v 1.4 2005/02/14 08:14:48 dholm Exp $

inherit eutils

DESCRIPTION="Emulates scrollwheel, right- & left-click for one-button mice/touchpads"
HOMEPAGE="http://geekounet.org/powerbook/"
SRC_URI="http://geekounet.org/powerbook/files/${PN}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/${PN} ${WORKDIR}/${P}
	epatch ${FILESDIR}/${P}-fix.diff
}

src_compile() {
	emake || die
}

src_install() {
	dosbin mouseemu
	dodoc README COPYING
	exeinto /etc/init.d/
	newexe mouseemu.init.gentoo mouseemu
	insinto /etc
	doins mouseemu.conf
}

pkg_postinst() {
	einfo "For mouseemu to work you need uinput support in your kernel:"
	einfo "        CONFIG_INPUT_UINPUT=y"
	einfo "(Device Drivers->Input device support->Misc->User level driver support)"
	einfo "Don't forget to add mouseemu to your default runlevel:"
	einfo "        rc-update add mouseemu default"
	einfo "Configuration is in /etc/mouseemu.conf."
}
