# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/fsviewer/fsviewer-0.2.5.ebuild,v 1.6 2007/01/26 17:16:00 s4t4n Exp $

inherit eutils

MY_PN="FSViewer"

DESCRIPTION="file system viewer for Window Maker"
HOMEPAGE="http://www.bayernline.de/~gscholz/linux/fsviewer/"
SRC_URI="http://www.bayernline.de/~gscholz/linux/${PN}/${MY_PN}.app-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE=""

DEPEND=">=x11-wm/windowmaker-0.92.0-r3
	|| ( (
		x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXmu
		x11-libs/libPropList
		x11-libs/libXpm
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXt
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )
	media-libs/tiff
	media-libs/libpng
	media-libs/jpeg
	media-libs/giflib
	media-libs/libpng
	media-libs/fontconfig
	media-libs/freetype
	dev-libs/expat
	sys-libs/zlib"

S="${WORKDIR}/${MY_PN}.app-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-windowmaker.patch
}

src_compile() {
	econf --with-appspath=/usr/lib/GNUstep \
		--with-extralibs=-lXft \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
