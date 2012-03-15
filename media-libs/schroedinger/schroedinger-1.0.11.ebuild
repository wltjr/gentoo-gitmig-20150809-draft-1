# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-1.0.11.ebuild,v 1.2 2012/03/15 17:43:16 grobian Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="C-based libraries for the Dirac video codec"
HOMEPAGE="http://www.diracvideo.org/"
SRC_URI="http://www.diracvideo.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2 MIT MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=">=dev-lang/orc-0.4.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gtk-doc-am"

src_prepare() {
	# from upstream, drop at next release
	epatch "${FILESDIR}"/${P}-darwin-compile.patch 

	sed -i \
		-e '/AS_COMPILER_FLAG(-O3/d' \
		configure.ac || die

	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html" \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
