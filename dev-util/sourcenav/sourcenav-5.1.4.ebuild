# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.1.4.ebuild,v 1.9 2005/11/26 06:04:50 nerdboy Exp $

inherit eutils libtool toolchain-funcs

S=${WORKDIR}/build

DESCRIPTION="Source-Navigator is a source code analysis tool"
SRC_URI="mirror://sourceforge/sourcenav/${P}.tar.gz
mirror://gentoo/${P}-gentoo.diff.gz"
HOMEPAGE="http://sourcenav.sourceforge.net"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~sparc ppc"
IUSE=""
DEPEND=">=sys-libs/glibc-2.2.4"
SN="/opt/sourcenav"

src_unpack() {
	unpack ${A}
	mkdir ${WORKDIR}/build
	cd ${WORKDIR}/${P}
	zcat ${DISTDIR}/${PF}-gentoo.diff.gz | patch -p0 || die "patch failed"
}

src_compile() {
	cd ${WORKDIR}/build
	../${P}/configure \
		--host=${CHOST} \
		--prefix=${SN} \
		--exec-prefix=${SN} \
		--bindir=${SN}/bin \
		--sbindir=${SN}/sbin \
		--mandir=${SN}/share/man \
		--infodir=${SN}/share/info \
		--datadir=${SN}/share \
		--libdir=${SN}/$(get_libdir) || die "configure failed"

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	chmod -Rf 755 ${D}/${SN}/share/doc/${P}/demos
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > ${D}/etc/env.d/10snavigator
}
