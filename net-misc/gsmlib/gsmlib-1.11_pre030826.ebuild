# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsmlib/gsmlib-1.11_pre030826.ebuild,v 1.7 2005/01/26 14:26:32 liquidx Exp $

inherit eutils

RESTRICT="maketest"

MY_A=${PN}-pre${PV%_pre*}-${PV#*_pre}

DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/snapshots/${MY_A}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND=""

IUSE=""
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc sparc ~amd64"

S=${WORKDIR}/${PN}-${PV%_pre*}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gsmlib-1.11-include-gcc34-fix.patch
}

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
