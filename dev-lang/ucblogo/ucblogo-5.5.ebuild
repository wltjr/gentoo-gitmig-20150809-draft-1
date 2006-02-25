# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ucblogo/ucblogo-5.5.ebuild,v 1.4 2006/02/25 05:42:34 vapier Exp $

inherit eutils

DESCRIPTION="a reflective, functional programming language"
HOMEPAGE="http://www.cs.berkeley.edu/~bh/logo.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs X"

DEPEND="emacs? ( virtual/emacs )
	X? ( || ( ( x11-libs/libICE x11-libs/libSM x11-libs/libX11 ) virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-destdir.patch
	epatch "${FILESDIR}"/${P}-fhs.patch
	epatch "${FILESDIR}"/${P}-dont-require-tetex.patch
	use emacs || echo 'all install:' > emacs/makefile
}

src_compile() {
	econf $(use_with X x) || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README
}
