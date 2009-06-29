# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvgrab/dvgrab-3.4.ebuild,v 1.2 2009/06/29 19:32:21 aballier Exp $

inherit eutils

DESCRIPTION="Digital Video (DV) grabber for GNU/Linux"
HOMEPAGE="http://www.kinodv.org/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="jpeg quicktime"

RDEPEND=">=sys-libs/libraw1394-1.1
	>=media-libs/libdv-0.103
	>=media-libs/libiec61883-1
	>=sys-libs/libavc1394-0.5.1
	jpeg? ( media-libs/jpeg )
	quicktime? ( media-libs/libquicktime )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc44.patch"
}

src_compile() {
	econf $(use_with quicktime libquicktime) $(use_with jpeg libjpeg)
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
