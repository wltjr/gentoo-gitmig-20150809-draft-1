# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/foxtrotgps/foxtrotgps-1.0.0.ebuild,v 1.2 2011/03/02 20:28:48 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Foxtrotgps is an easy to use, fast and lightweight mapping
application. (fork of tangogps)"
HOMEPAGE="http://www.foxtrotgps.org/"
SRC_URI="http://www.foxtrotgps.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2
	sys-apps/dbus
	gnome-base/gconf:2
	net-misc/curl
	media-libs/libexif
	dev-libs/libxml2:2
	>=sci-geosciences/gpsd-2.90"
DEPEND="
	sys-devel/gettext
	${RDEPEND}"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${P} \
		|| die "Configure failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
