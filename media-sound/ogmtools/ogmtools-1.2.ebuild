# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogmtools/ogmtools-1.2.ebuild,v 1.4 2004/02/23 13:03:32 eradicator Exp $

DESCRIPTION="These tools allow information about (ogminfo) or extraction from (ogmdemux) or creation of (ogmmerge) OGG media streams"
HOMEPAGE="http://www.bunkus.org/videotools/ogmtools/"
SRC_URI="http://www.bunkus.org/videotools/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="dvd"

DEPEND="dvd? ( media-libs/libdvdread )
	>=sys-devel/automake-1.6.0
	media-sound/vorbis-tools"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin ogmmerge ogmdemux ogminfo ogmsplit ogmcat dvdxchap || die
	dodoc INSTALL TODO README ChangeLog
	doman dvdxchap.1 ogmcat.1 ogmdemux.1 ogminfo.1 ogmmerge.1 ogmsplit.1
}
