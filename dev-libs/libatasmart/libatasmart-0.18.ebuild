# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libatasmart/libatasmart-0.18.ebuild,v 1.6 2011/12/11 15:49:49 armin76 Exp $

EAPI=4

DESCRIPTION="Lean and small library for ATA S.M.A.R.T. hard disks"
HOMEPAGE="http://0pointer.de/blog/projects/being-smart.html"
SRC_URI="http://0pointer.de/public/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~ppc64 sh sparc x86"
IUSE="static-libs"

RDEPEND=">=sys-fs/udev-143"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
}
