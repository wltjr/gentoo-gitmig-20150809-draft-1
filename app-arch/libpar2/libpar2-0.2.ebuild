# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/libpar2/libpar2-0.2.ebuild,v 1.3 2008/06/04 18:31:54 klausman Exp $

DESCRIPTION="A library for par2, extracted from par2cmdline"
HOMEPAGE="http://parchive.sourceforge.net/"
SRC_URI="mirror://sourceforge/parchive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 x86"
IUSE=""

DEPEND="dev-libs/libsigc++"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
