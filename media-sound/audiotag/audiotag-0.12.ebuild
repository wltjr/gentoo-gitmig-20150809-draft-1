# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiotag/audiotag-0.12.ebuild,v 1.2 2004/09/04 20:19:00 fvdpol Exp $

DESCRIPTION="A command-line audio file meta-data tagger. Sets id3 and/or vorbis tags in mp3, ogg, and flac files."
HOMEPAGE="http://tempestgames.com/ryan/"
SRC_URI="http://tempestgames.com/ryan/downloads/audiotag-0.12.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="flac oggvorbis"

DEPEND="dev-lang/perl"
RDEPEND="flac? ( media-libs/flac )
	oggvorbis? ( media-sound/vorbis-tools )
	media-libs/id3lib"

src_install() {
	dobin audiotag
	dodoc README ChangeLog
}

