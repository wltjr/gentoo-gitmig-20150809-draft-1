# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-2.0.ebuild,v 1.3 2003/10/19 21:12:23 seemant Exp $

BUSYBOX="busybox-0.60.5"
CLOOP="cloop_1.02-1"

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://emu.gentoo.org/~zhen/genkernel-2.0.tar.bz2
		 http://dev.gentoo.org/~zhen/${BUSYBOX}.tar.gz
		 http://dev.gentoo.org/~zhen/${CLOOP_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	insinto /etc/kernels
	doins files/settings files/default-config-*

	exeinto /usr/sbin
	doexe genkernel

	#Put general files in /usr/share/genkernel for FHS compliance
	insinto /usr/share/genkernel
	doins src/linuxrc src/key.lst src/1024.initrd files/livecdrc ${DISTDIR}/${BUSYBOX} ${DISTDIR}/${CLOOP}

	dodoc README
	dodoc ChangeLog
}
