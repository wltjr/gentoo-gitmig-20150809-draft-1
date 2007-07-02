# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mknbi/mknbi-1.4.3.ebuild,v 1.9 2007/07/02 15:02:07 peper Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Utility for making tagged kernel images useful for netbooting"
SRC_URI="mirror://sourceforge/etherboot/${P}.tar.gz"
RESTRICT="mirror"
HOMEPAGE="http://etherboot.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-lang/nasm"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/mknbi-1.4.3-nossp.patch
}

src_compile()
{
	sed -i -e "s:\/usr\/local:\/usr:"  Makefile

	#apply modifications to CFLAGS to fix for gcc 3.4: bug #64049
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		sed -i -e "s:\-mcpu:\-mtune:" Makefile
		sed -i -e "s:CFLAGS=:CFLAGS= -minline-all-stringops:" Makefile
	fi

	emake || die "Compile failed"
}

src_install()
{
	export BUILD_ROOT=${D}
	dodoc COPYING
	make DESTDIR=${D} install || die "Installing failed"
}
