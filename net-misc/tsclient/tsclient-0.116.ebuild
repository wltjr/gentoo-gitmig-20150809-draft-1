# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsclient/tsclient-0.116.ebuild,v 1.5 2004/06/25 00:16:34 agriffis Exp $

DESCRIPTION="GTK2 frontend for rdesktop"
HOMEPAGE="http://www.gnomepro.com/tsclient"
SRC_URI="http://www.gnomepro.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	>=net-misc/rdesktop-1.1.0
	>=dev-libs/glib-2.0
	>=gnome-base/gnome-panel-2.0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	  dev-util/pkgconfig"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install
	insinto /usr/share/applications
	doins ${FILESDIR}/tsclient.desktop
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION
}
