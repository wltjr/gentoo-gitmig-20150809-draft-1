# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tables/scim-tables-0.2.2.ebuild,v 1.3 2004/04/25 22:11:28 agriffis Exp $

DESCRIPTION="Smart Common Input Method (SCIM) Generic Table Input Method Server"
HOMEPAGE="http://www.turbolinux.com.cn/~suzhe/scim/"
SRC_URI="http://www.turbolinux.com.cn/~suzhe/scim//sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=app-i18n/scim-0.5.1"

S=${WORKDIR}/${P}

src_compile() {
	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc README ChangeLog AUTHORS
}
