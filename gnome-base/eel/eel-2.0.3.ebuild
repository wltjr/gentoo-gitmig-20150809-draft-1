# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.0.3.ebuild,v 1.1 2002/08/06 09:25:17 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="EEL is the Eazel Extentions Library"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2.1" 
KEYWORDS="x86 ppc"

RDEPEND=">=dev-libs/glib-2.0.6-r1
	>=gnome-base/gconf-1.2.1
	>=x11-libs/gtk+-2.0.6-r1
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/gnome-vfs-2.0.2
	>=dev-libs/popt-1.6.3
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/bonobo-activation-1.0.3
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/gail-0.16"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"		

LIBTOOL_FIX="1"

DOCS="AUTHORS ChangeLog COPYING* HACKING THANKS README* INSTALL NEWS TODO MAINTAINERS"

src_compile() {
	gnome2_src_compile --enable-platform-gnome-2
}

