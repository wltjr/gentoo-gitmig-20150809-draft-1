# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-1.0.1.ebuild,v 1.1 2009/06/27 11:44:42 patrick Exp $

EAPI="2"

inherit fixheadtails multilib eutils

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="image truetype"

DEPEND=">=dev-lang/erlang-12b
	>=media-libs/libsdl-1.2.5[opengl]
	image? ( media-libs/sdl-ttf )
	truetype? ( media-libs/sdl-image )
	virtual/opengl"

src_prepare() {
	sed -i "/CFLAGS.*=/s:-g -O2 -funroll-loops -Wall -ffast-math:${CFLAGS}:" c_src/Makefile
	ht_fix_file Makefile c_src/Makefile
	if use image ; then
		sed -i "/ENABLE_SDL_IMAGE = /s:no:yes:" Makefile
	fi
	if use truetype ; then
		sed -i "/ENABLE_SDL_TTF = /s:no:yes:" Makefile
	fi
}

src_compile() {
	emake || die
}

src_install() {
	addpredict /usr/$(get_libdir)/erlang/lib
	ERLANG_DIR="/usr/$(get_libdir)/erlang/lib"
	ESDL_DIR="${ERLANG_DIR}/${P}"
	dodir ${ESDL_DIR}
	make install INSTALLDIR="${D}"/${ESDL_DIR} || die "make install"
}
