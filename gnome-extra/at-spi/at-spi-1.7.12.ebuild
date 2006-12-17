# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.7.12.ebuild,v 1.5 2006/12/17 00:58:34 dertobi123 Exp $

WANT_AUTOMAKE="1.9"

inherit virtualx autotools eutils gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/atk-1.12
	>=gnome-base/libbonobo-1.107
	>=gnome-base/gail-1.3
	>=x11-libs/gtk+-2
	>=gnome-base/orbit-2
	dev-libs/popt

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1 )

	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/inputproto
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README TODO"


src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}"/${P}-tests.patch

	cp aclocal.m4 old_macros.m4
	AT_M4DIR="." eautoreconf
}

src_test() {
	Xmake check || die "Testing phase failed"
}
