# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.4.4-r1.ebuild,v 1.5 2004/06/29 13:26:49 vapier Exp $

inherit kde
need-kde 3

DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/qt
	virtual/x11
	sys-libs/zlib
	dev-libs/expat
	sys-devel/gcc
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-libs/libmng
	media-libs/libpng
	media-libs/nas
	sys-devel/gcc
	dev-embedded/gputils
	app-admin/fam
	virtual/libc"
# build system uses some perl
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-devel/gcc-3
	>=sys-apps/sed-4"

src_compile() {
	kde_src_compile myconf configure
	sed -i -e "s#\(kde_.* = \)\${prefix}\(.*\)#\1${KDEDIR}\2#g" Makefile */Makefile
	kde_src_compile make
}

pkg_postinst() {
	einfo "The author request you email alain.gibaud@free.fr when you install this program. See the"
	einfo "http://pikdev.free.fr/download.php3 for details"
}
