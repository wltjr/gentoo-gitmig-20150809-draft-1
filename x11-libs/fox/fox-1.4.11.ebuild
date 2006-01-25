# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.4.11.ebuild,v 1.6 2006/01/25 05:08:14 spyderous Exp $

IUSE="cups debug truetype opengl X tiff png jpeg zlib bzip2"
DESCRIPTION="C++ based Toolkit for developing Graphical User Interfaces easily and effectively"
SRC_URI="http://www.fox-toolkit.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.fox-toolkit.org"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~hppa ~alpha ~ppc64"
LICENSE="GPL-2"

RDEPEND="virtual/libc
	|| ( x11-libs/libXrandr virtual/x11 )
	truetype? ( >=media-libs/freetype-2 )
	opengl? ( virtual/opengl virtual/glu )
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )
	X? ( || ( x11-libs/libXcursor virtual/x11 ) )"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
			x11-libs/libXt
		)
		virtual/x11
	)"


src_compile() {
	local myconf

	# Following line closes #61694
	CPPFLAGS="$CPPFLAGS -I/usr/include/freetype2" \
	econf \
		`use_with opengl` \
		`use_enable cups` \
		`use_enable debug` \
		`use_enable tiff` \
		`use_enable jpeg` \
		`use_enable png` \
		`use_enable zlib` \
		`use_enable bzip2 bz2lib` \
		`use_with truetype xft` \
		`use_with X xshm` `use_with X xcursor` \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install () {
	make DESTDIR="${D}" install || die

	dodoc README INSTALL LICENSE ADDITIONS AUTHORS TRACING

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/fox/html/* ${D}/usr/share/doc/${PF}/html/
	rmdir ${D}/usr/fox/html
	rmdir ${D}/usr/fox
}
