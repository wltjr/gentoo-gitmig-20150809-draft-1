# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvmysql/dvmysql-0.4.7.ebuild,v 1.4 2004/03/14 12:28:57 mr_bones_ Exp $

inherit eutils

A=dvmysql-${PV}.tar.gz
S=${WORKDIR}/dvmysql-${PV}
DESCRIPTION="dvmysql provides a C++ interface to mysql"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvmysql/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-db/mysql
	dev-libs/dvutil"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gentoo-0.4.7.patch || die
}

src_install() {
	make prefix=${D}/usr install
}
