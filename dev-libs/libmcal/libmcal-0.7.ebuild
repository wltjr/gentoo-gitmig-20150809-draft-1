# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcal/libmcal-0.7.ebuild,v 1.9 2004/08/19 03:51:49 tgall Exp $

DESCRIPTION="Modular Calendar Access Library"
HOMEPAGE="http://mcal.chek.com/"
SRC_URI="mirror://sourceforge/libmcal/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ppc sparc ~alpha ~hppa ~mips ppc64"

IUSE=""
DEPEND=""
RDEPEND=""
S=${WORKDIR}/${PN}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc CHANGELOG FAQ-MCAL FEATURE-IMPLEMENTATION HOW-TO-MCAL LICENSE README
	dohtml FUNCTION-REF.html
}
