# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxlauncher/lxlauncher-0.2.1-r1.ebuild,v 1.2 2011/06/01 10:24:21 klausman Exp $

EAPI="1"

inherit autotools eutils

DESCRIPTION="An open source clone of the Asus launcher for EeePC"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	gnome-base/gnome-menus
	x11-libs/startup-notification"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	lxde-base/menu-cache
	!lxde-base/lxlauncher-gmenu"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-intltool.patch
	epatch "${FILESDIR}"/${P}-fix-segfault.patch

	# Rerun autotools
	einfo "Regenerating autotools files..."
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
