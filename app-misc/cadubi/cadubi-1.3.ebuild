# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cadubi/cadubi-1.3.ebuild,v 1.4 2004/06/24 22:04:23 agriffis Exp $

inherit eutils

DESCRIPTION="CADUBI is an application that allows you to draw ASCII-Art images"
HOMEPAGE="http://langworth.com/CadubiProject"
SRC_URI="http://langworth.com/downloads/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="dev-lang/perl
	>=dev-perl/TermReadKey-2.21"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-helpfile.patch
}

src_install() {
	dobin cadubi
	insinto /usr/lib/${PN}
	doins help.txt
	dodoc LICENSE README
}
