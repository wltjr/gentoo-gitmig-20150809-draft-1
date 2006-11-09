# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-0.9.7.ebuild,v 1.3 2006/11/09 04:17:17 vapier Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.9"

inherit eutils libtool autotools

DESCRIPTION="Provides a simple foundation for reading DVD-Video images."
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/libdvdcss-1.1.1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-udfsymbols.patch"

	eautoreconf
	elibtoolize
}

src_compile() {
	local myconf=""
	use ppc-macos && myconf="--with-libdvdcss=/usr"
	econf ${myconf} || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dobin src/.libs/*  # install executables
	cd ${D}usr/bin
	mv ./ifo_dump ./ifo_dump_dvdread

	cd ${S}
	dodoc AUTHORS ChangeLog NEWS README TODO
}
