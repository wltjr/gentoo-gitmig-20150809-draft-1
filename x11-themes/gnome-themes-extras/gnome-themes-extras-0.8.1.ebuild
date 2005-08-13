# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes-extras/gnome-themes-extras-0.8.1.ebuild,v 1.5 2005/08/13 23:29:09 hansmi Exp $

inherit gnome2 eutils

DESCRIPTION="Additional themes for GNOME 2.2"
HOMEPAGE="http://librsvg.sourceforge.net/theme.php"

LICENSE="LGPL-2.1 GPL-2 DSL"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	>=x11-themes/gtk-engines-2.6
	gnome-base/librsvg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23"

DOCS="AUTHORS ChangeLog MAINTAINERS README TODO"

pkg_postinst() {
	einfo "Updating Icon Cache"

	gtk-update-icon-cache -qf /usr/share/icons/Amaranth
	gtk-update-icon-cache -qf /usr/share/icons/Gorilla
	gtk-update-icon-cache -qf /usr/share/icons/Lush
	gtk-update-icon-cache -qf /usr/share/icons/Nuvola
	gtk-update-icon-cache -qf /usr/share/icons/Wasp
}
