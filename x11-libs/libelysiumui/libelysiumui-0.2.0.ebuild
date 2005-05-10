# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libelysiumui/libelysiumui-0.2.0.ebuild,v 1.5 2005/05/10 09:35:34 dholm Exp $

DESCRIPTION="User Interface enhancements for Elysium GNU/Linux"
HOMEPAGE="http://elysium-project.sourceforge.net"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2"

src_install() {
	einstall || die "install failed"
}
