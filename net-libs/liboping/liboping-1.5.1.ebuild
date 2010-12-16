# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liboping/liboping-1.5.1.ebuild,v 1.1 2010/12/16 23:31:14 dilfridge Exp $

EAPI=3

DESCRIPTION="C library and ncurses based program to generate ICMP echo requests and ping multiple hosts at once"
HOMEPAGE="http://verplant.org/liboping"
SRC_URI="http://verplant.org/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="perl"

DEPEND="
	sys-libs/ncurses
	perl? ( dev-lang/perl sys-devel/libperl  )
"
RDEPEND=${DEPEND}

src_configure() {
	econf $(use_with perl perl-bindings) --disable-static
}

src_install() {
	make DESTDIR="${D}" install || die
	find "${D}" -name '*.la'  -delete
}
