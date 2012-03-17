# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/vicious/vicious-2.0.3.ebuild,v 1.3 2012/03/17 21:38:25 chainsaw Exp $

EAPI=3

DESCRIPTION="Modular widget library for x11-wm/awesome"
HOMEPAGE="http://awesome.naquadah.org/wiki/Vicious"
SRC_URI="http://dev.gentoo.org/~wired/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="=x11-wm/awesome-3.4*"

src_install() {
	insinto /usr/share/awesome/lib/vicious
	doins -r widgets helpers.lua init.lua || die "Install failed"
	dodoc CHANGES README TODO || die "dodoc failed"
}
