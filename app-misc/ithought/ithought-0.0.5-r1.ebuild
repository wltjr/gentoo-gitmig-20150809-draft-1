# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ithought/ithought-0.0.5-r1.ebuild,v 1.16 2004/06/24 22:16:05 agriffis Exp $

#emerge doesn't yet support things like a5

MY_P=${P/0.0./a}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An internet-aware personal thought manager"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://ithought.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	dev-libs/libxml2"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
