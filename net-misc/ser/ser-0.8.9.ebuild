# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser/ser-0.8.9.ebuild,v 1.9 2004/12/25 17:24:52 ticho Exp $

DESCRIPTION="SIP Express Router"

HOMEPAGE="http://www.iptel.org/ser"
SRC_URI="ftp://ftp.berlios.de/pub/ser/${PV}/src/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ipv6 mysql"

DEPEND=">=sys-devel/gcc-2.95.3
		>=sys-devel/bison-1.35
		>=sys-devel/flex-2.5.4a
		mysql? ( >=dev-db/mysql-3.23.52 )"

src_compile() {
	if ! use ipv6; then
		cp Makefile.defs Makefile.defs.orig
		sed -e "s/-DUSE_IPV6//g" Makefile.defs.orig > Makefile.defs;
	fi
	if use mysql; then
		cp Makefile Makefile.orig
		sed -e "s/ mysql //g" Makefile.orig > Makefile;
	fi
	make all CFLAGS="${CFLAGS}" \
		prefix=${D}/ \
		cfg-prefix=/ \
		cfg-target=/etc/ser/ || die
	cd utils/gen_ha1
	make all || die
}

src_install () {
	make install \
		prefix=${D}/ \
		bin-prefix=${D}/usr/sbin \
		bin-dir="" \
		cfg-prefix=${D}/etc \
		cfg-dir=ser/ \
		cfg-target=/etc/ser \
		modules-prefix=${D}/usr/lib/ser \
		modules-dir=modules \
		modules-target=/usr/lib/ser/modules/ \
		man-prefix=${D}/usr/share/man \
		man-dir="" \
		doc-prefix=${D}/usr/share/doc \
		doc-dir=${P} || die
	exeinto /etc/init.d
	newexe gentoo/ser.init ser
	exeinto /usr/bin
	newexe utils/gen_ha1/gen_ha1 gen_ha1
	exeinto /usr/sbin
	newexe scripts/harv_ser.sh harv_ser.sh
	newexe scripts/sc serctl
	newexe scripts/ser_mysql.sh ser_mysql.sh
}
