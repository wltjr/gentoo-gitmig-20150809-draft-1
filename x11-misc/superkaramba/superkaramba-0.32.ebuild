# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superkaramba/superkaramba-0.32.ebuild,v 1.3 2004/03/14 17:31:51 mr_bones_ Exp $

inherit kde

need-kde 3

DESCRIPTION="A version of Karamba with extra extensions in-built"
HOMEPAGE="http://netdragon.sourceforge.net/"
SRC_URI="mirror://sourceforge/netdragon/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

newdepend ">=kde-base/kdelibs-3.1
	>=sys-apps/portage-2.0.26"

src_install () {
	einstall
	dodir /usr/share/doc/${P} /usr/share/karamba/themes /usr/share/karamba/bin
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}
	> ${D}/usr/share/karamba/themes/.keep
	> ${D}/usr/share/karamba/bin/.keep

	dodir /etc/env.d
	cp ${FILESDIR}/karamba-env ${D}/etc/env.d/99karamba
}
