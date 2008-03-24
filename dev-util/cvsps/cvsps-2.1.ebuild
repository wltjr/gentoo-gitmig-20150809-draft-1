# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsps/cvsps-2.1.ebuild,v 1.15 2008/03/24 11:16:30 vapier Exp $

inherit eutils

MY_P="${P/_/}"
DESCRIPTION="Generates patchset information from a CVS repository"
HOMEPAGE="http://www.cobite.com/cvsps/"
SRC_URI="http://www.cobite.com/cvsps/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/zlib"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dobin cvsps || die
	doman cvsps.1
	dodoc README CHANGELOG
}
