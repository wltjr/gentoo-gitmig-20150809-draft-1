# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kioslaves/kdemultimedia-kioslaves-4.3.4.ebuild,v 1.3 2010/01/22 00:17:51 abcd Exp $

EAPI="2"

KMNAME="kdemultimedia"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook encode flac vorbis"

# 4 of 9 tests fail. Last checked for 4.2.88
RESTRICT=test

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-sound/cdparanoia
	encode? (
		flac? ( >=media-libs/flac-1.1.2 )
		vorbis? ( media-libs/libvorbis )
	)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkcompactdisc/
"
KMCOMPILEONLY="
	libkcddb/
"

KMLOADLIBS="libkcddb"

src_configure() {
	if use encode; then
		mycmakeargs=(
			$(cmake-utils_use_with flac)
			$(cmake-utils_use_with vorbis OggVorbis)
		)
	else
		mycmakeargs=(-DWITH_OggVorbis=OFF -DWITH_Flac=OFF)
	fi

	kde4-meta_src_configure
}
