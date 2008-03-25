# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinepaint/cinepaint-0.22.1.ebuild,v 1.1 2008/03/25 22:12:48 aballier Exp $

inherit eutils versionator flag-o-matic

MY_PV=$(replace_version_separator 2 '-')
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/cinepaint/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://cinepaint.sourceforge.net/"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
IUSE="gimpprint png zlib"

RDEPEND=">=x11-libs/gtk+-2.0
	png? ( >=media-libs/libpng-1.2 )
	zlib? ( sys-libs/zlib )
	gimpprint? ( >=media-gfx/gimp-print-5.0.0 )
	media-libs/openexr
	>=media-libs/lcms-1.16
	media-libs/tiff
	media-libs/jpeg
	x11-libs/fltk
	x11-libs/libXmu
	x11-libs/libXinerama
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xineramaproto"

src_compile(){
	econf $(use_enable gimpprint print) --enable-gtk2 || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README NEWS
}
