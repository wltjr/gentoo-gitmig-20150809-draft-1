# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-cdread/xmms-cdread-0.14a-r1.ebuild,v 1.1 2003/09/20 10:09:38 jje Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XMMS plugin to read audio cdroms as data"
HOMEPAGE="ftp://mud.stack.nl/pub/OuterSpace/willem/"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-sound/xmms-1.2.8"

src_unpack () {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-xmms-1.2.8.patch
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README ChangeLog INSTALL NEWS TODO
}
