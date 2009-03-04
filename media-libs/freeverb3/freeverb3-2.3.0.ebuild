# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeverb3/freeverb3-2.3.0.ebuild,v 1.1 2009/03/04 20:33:43 yngwin Exp $

EAPI=2
inherit eutils

DESCRIPTION="High Quality Reverb and Impulse Response Convolution library including XMMS/Audacious Effect plugins"
HOMEPAGE="http://freeverb3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audacious jack plugdouble sse sse2 3dnow forcefpu"

RDEPEND=">=sci-libs/fftw-3.0.1
	audacious? ( media-sound/audacious
		media-libs/libsndfile )
	jack? ( media-sound/jack-audio-connection-kit
		media-libs/libsndfile )"
DEPEND=${RDEPEND}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-implicit.patch
}

src_configure() {
	econf \
		--enable-release \
		--disable-bmp \
		$(use_enable audacious) \
		$(use_enable jack) \
		$(use_enable plugdouble) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable 3dnow) \
		$(use_enable forcefpu) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
