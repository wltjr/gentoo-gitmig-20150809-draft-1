# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libticables/libticables-3.7.7.ebuild,v 1.1 2003/11/04 11:04:18 phosphan Exp $

DESCRIPTION="libticables is a necessary library for the TiLP calculator linking program."
HOMEPAGE="http://tilp.sourceforge.net/"

SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
# Only tested on x86 so far...
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall aclocaldir=${D}/usr/share/aclocal || die
}
