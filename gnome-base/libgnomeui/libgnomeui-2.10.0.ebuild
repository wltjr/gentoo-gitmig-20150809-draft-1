# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeui/libgnomeui-2.10.0.ebuild,v 1.6 2005/06/12 12:25:01 dertobi123 Exp $

inherit gnome2 eutils

DESCRIPTION="User Interface routines for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc jpeg"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=x11-libs/pango-1.1.2
	>=dev-libs/popt-1.5
	>=media-sound/esound-0.2.26
	>=media-libs/audiofile-0.2.3
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2.7.3
	gnome-base/gnome-keyring
	jpeg? ( media-libs/jpeg )"

# FIXME : jpeg stuff no switch

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.6 )"

PDEPEND="x11-themes/gnome-themes
	x11-themes/gnome-icon-theme"

src_unpack() {

	unpack ${A}
	cd ${S}
	# cleanliness is ... (#68698)
	epatch ${FILESDIR}/${PN}-2.8.0-ditch_ancient_pics.patch

	automake || die
}
DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"
