# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.4.0-r1.ebuild,v 1.7 2005/06/11 06:48:00 vapier Exp $

inherit eutils

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc-macos ~ppc64 sparc x86"
IUSE="debug ipv6 oss"

DEPEND="virtual/x11
	>=dev-libs/openssl-0.9.6b"

src_unpack() {
	unpack ${A}
	# Patch provided by Richard Brown <mynamewasgone@gmail.com> to bug #88684
	epatch ${FILESDIR}/${P}-configure-with_arg.patch
}

src_compile() {
	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure
	econf \
		--with-openssl=/usr \
		`use_with debug` \
		`use_with ipv6` \
		`use_with oss sound` \
		 || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
