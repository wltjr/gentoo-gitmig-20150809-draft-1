# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ASFiles/ASFiles-1.0.ebuild,v 1.12 2004/05/23 14:10:06 pvdabeel Exp $

inherit eutils

DESCRIPTION="NeXTish filemanager, hacked from OffiX"
SRC_URI="http://www.tigr.net/afterstep/download/ASFiles/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/view.php?applet=ASFiles/data"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""
DEPEND=">=x11-wm/afterstep-1.8.8
		>=x11-libs/dnd-1.1"
RDEPEND=$DEPEND

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	econf \
		--with-x \
		--with-dnd-inc=/usr/include/OffiX \
		--with-dnd-lib=/usr/lib || die
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		install || die

}

