# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dclib/dclib-0.3.5.ebuild,v 1.5 2005/05/30 20:01:36 swegener Exp $

inherit toolchain-funcs eutils

DESCRIPTION="DirectConnect client library"
HOMEPAGE="http://dcgui.berlios.de/"
SRC_URI="http://download.berlios.de/dcgui/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~alpha ~hppa ia64 amd64"

DEPEND=">=app-arch/bzip2-1.0.2
	>=dev-libs/libxml2-2.4.22"

src_unpack() {
	unpack ${A}
	cd ${S}
	[ `gcc-major-version` == 2 ] && epatch ${FILESDIR}/${P}-gcc2.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
