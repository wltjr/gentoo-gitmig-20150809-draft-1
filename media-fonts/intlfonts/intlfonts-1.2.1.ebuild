# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/intlfonts/intlfonts-1.2.1.ebuild,v 1.16 2009/06/24 05:28:41 jer Exp $

inherit font

IUSE="X bdf"

DESCRIPTION="International X11 fixed fonts"
HOMEPAGE="http://www.gnu.org/directory/intlfonts.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

DEPEND="x11-apps/bdftopcf"

src_compile() {
	econf --with-fontdir=/usr/share/fonts/${PN} || die
}

src_install() {
	make install fontdir="${D}/usr/share/fonts/${PN}" || die
	find "${D}/usr/share/fonts/${PN}" -name '*.pcf' | xargs gzip -9
	use bdf || rm -rf "${D}/usr/share/fonts/${PN}/bdf"
	dodoc ChangeLog NEWS README
	dodoc Emacs.ap
	font_xfont_config
	font_xft_config
}
