# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gifsicle/gifsicle-1.44.ebuild,v 1.6 2007/03/15 17:40:15 corsair Exp $

DESCRIPTION="A UNIX command-line tool for creating, editing, and getting information about GIF images and animations"
HOMEPAGE="http://www.lcdf.org/~eddietwo/gifsicle/"
SRC_URI="http://www.lcdf.org/~eddietwo/gifsicle/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc-macos ~ppc64 ~sparc x86"
IUSE="X"

DEPEND="X? ( || ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-proto/xproto )
		virtual/x11 ) )"

src_compile() {
	local myconf

	use X || myconf="${myconf} --disable-gifview"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README
}
