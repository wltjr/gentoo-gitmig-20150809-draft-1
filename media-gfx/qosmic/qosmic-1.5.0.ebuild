# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qosmic/qosmic-1.5.0.ebuild,v 1.2 2012/05/05 07:00:23 jdhore Exp $

EAPI=4
inherit qt4-r2

DESCRIPTION="A cosmic recursive flame fractal editor"
HOMEPAGE="http://code.google.com/p/qosmic/"
SRC_URI="http://qosmic.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/lua-5.1.4
	>=media-gfx/flam3-3.0.1
	>=x11-libs/qt-gui-4.6:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="changes.txt README"
