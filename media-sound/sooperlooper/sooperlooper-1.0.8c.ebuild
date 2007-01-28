# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sooperlooper/sooperlooper-1.0.8c.ebuild,v 1.1 2007/01/28 04:27:02 dirtyepic Exp $

WX_GTK_VER="2.6"

inherit wxwidgets

DESCRIPTION="Live looping sampler with immediate loop recording"
HOMEPAGE="http://essej.net/sooperlooper/index.html"
SRC_URI="http://essej.net/sooperlooper/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-sound/jack-audio-connection-kit-0.80.0
		=x11-libs/wxGTK-2.6*
		>=media-libs/liblo-0.17
		=dev-libs/libsigc++-1.2*
		media-libs/libsndfile
		media-libs/libsamplerate
		sys-libs/ncurses
		dev-libs/libxml2"

src_compile() {
	need-wxwidgets gtk2
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
