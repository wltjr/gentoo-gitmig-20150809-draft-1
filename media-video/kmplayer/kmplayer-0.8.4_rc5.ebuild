# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.8.4_rc5.ebuild,v 1.1 2005/01/07 22:02:17 carlo Exp $

inherit kde eutils

MY_P="${P/_rc/-rc}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gstreamer xine"

# Removed koffice plugin, since compilation fails and its not supported upstream.
DEPEND=">=media-video/mplayer-0.90
	xine? ( >=media-libs/xine-lib-1_beta12 )
	gstreamer? ( media-libs/gstreamer )"
need-kde 3.1

src_unpack(){
	kde_src_unpack
	epatch ${FILESDIR}/xine.diff
	rm -f $S/configure
}
src_compile(){
	local myconf="$(use_with gstreamer) $(use_with xine)"
	kde_src_compile
}
