# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bmf/bmf-0.9.4.ebuild,v 1.7 2006/11/23 15:51:12 vivo Exp $

IUSE="mysql berkdb"

DESCRIPTION="A fast and small Bayesian spam filter"
HOMEPAGE="http://bmf.sourceforge.net/"
SRC_URI="mirror://sourceforge/bmf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="mysql? ( virtual/mysql )
	berkdb? ( >=sys-libs/db-3.2.9 )"

src_compile() {
	local myconf

	use mysql || myconf="--without-mysql"
	use berkdb || myconf="${myconf} --without-libdb"

	./configure ${myconf} || die "configure failed"
	emake
}

src_install() {
	dodoc README AUTHORS ChangeLog
	einstall DESTDIR=${D}
}

pkg_postinst() {
	einfo
	einfo "Important: Remember to train bmf before you start using it."
	einfo "Instructions for training and using bmf with procmail: "
	einfo "less /usr/share/doc/${P}/README.gz"
	einfo
}
