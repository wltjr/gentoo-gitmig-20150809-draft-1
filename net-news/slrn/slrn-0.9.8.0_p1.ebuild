# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/slrn/slrn-0.9.8.0_p1.ebuild,v 1.1 2004/10/02 19:26:50 swegener Exp $

inherit eutils

MY_P="${P/_p/pl}"

DESCRIPTION="s-lang Newsreader"
HOMEPAGE="http://slrn.sourceforge.net/"
SRC_URI="http://slrn.sourceforge.net/patches/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~ppc ~x86"
IUSE="ssl nls unicode uudeview"

RDEPEND="virtual/mta
	>=app-arch/sharutils-4.2.1
	>=sys-libs/slang-1.4.9-r1
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND}
	uudeview? ( dev-libs/uulib )
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	use unicode && epatch ${FILESDIR}/0.9.8.0/slrn-0.9.8.0-utf8.patch
}

src_compile() {
	econf \
		--with-docdir=/usr/share/doc/${PF} \
		--with-slrnpull \
		`use_enable nls` \
		`use_with ssl` \
		`use_with uudeview` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
}
