# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/nikibot/nikibot-0.8.ebuild,v 1.4 2007/02/28 16:50:47 armin76 Exp $

inherit autotools

DESCRIPTION="An IRC-Bot with lua script interface"
HOMEPAGE="http://sourceforge.net/projects/nikibot/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~x86"

RDEPEND="=dev-lang/lua-5.0*"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc README test.lua || die "dodoc failed"
	dohtml html/* || die "dohtml failed"
}
