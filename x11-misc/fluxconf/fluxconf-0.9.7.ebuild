# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.9.7.ebuild,v 1.9 2004/11/01 20:55:34 corsair Exp $

IUSE=""

DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha amd64 ~ppc64"

DEPEND="=x11-libs/gtk+-1.2*"

src_install () {
	einstall || die
	rm ${D}/usr/bin/fluxkeys ${D}/usr/bin/fluxmenu

	dosym /usr/bin/fluxconf /usr/bin/fluxkeys
	dosym /usr/bin/fluxconf /usr/bin/fluxmenu
	dosym /usr/bin/fluxconf /usr/bin/fluxbare

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
