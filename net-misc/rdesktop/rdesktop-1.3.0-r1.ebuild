# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.3.0-r1.ebuild,v 1.6 2004/06/25 00:08:05 agriffis Exp $

inherit eutils

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc amd64 ia64"
IUSE="ssl debug"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Adds extra functionality to the geometry settings, allowing for example:
	# -g1024x768+10+10
	# Patch is from Martin Gallwey and ported from rdesktop 1.2.0 and submitted
	# by Daniele Foci (sunscan@sunscan.org)
	# http://sourceforge.net/tracker/index.php?func=detail&aid=664800&group_id=24366&atid=381349

	epatch ${FILESDIR}/rdesktop-1.3.0-geometry.patch

	# This second patch gives rdesktop the ability to emulate Windows 2000's
	# built-in license.  This is especially useful for testing deployments.  I
	# am including it for PXES.

	epatch ${FILESDIR}/rdesktop-1.3.0-builtin-license.patch

	# This third patch has been applied to the rdesktop CVS and fixes some
	# problems with certificates on Windows 2000 and 2003, using RDP5.

	epatch ${FILESDIR}/rdesktop-1.3.0-last-two-certs.patch
}

src_compile() {
	local myconf
	use ssl \
		&& myconf="--with-openssl=/usr/include/openssl" \
		|| myconf="--without-openssl"

	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sharedir=/usr/share/${PN} \
		`use_with debug` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
