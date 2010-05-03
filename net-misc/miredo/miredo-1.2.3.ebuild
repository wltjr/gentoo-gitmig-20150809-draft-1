# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miredo/miredo-1.2.3.ebuild,v 1.1 2010/05/03 09:59:23 bangert Exp $

EAPI=3

inherit eutils

DESCRIPTION="Miredo is an open-source Teredo IPv6 tunneling software."
HOMEPAGE="http://www.remlab.net/miredo/"
SRC_URI="http://www.remlab.net/files/miredo/miredo-1.2.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+caps"

DEPEND="dev-libs/judy
	caps? ( sys-libs/libcap )"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

src_configure() {
	econf --enable-miredo-user \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--docdir="/usr/share/doc/${P}"
	use caps || \
		echo "#undef HAVE_SYS_CAPABILITY_H" >> config.h
}

src_install() {
	emake DESTDIR="${D}" install || die "failed install"
	newinitd "${FILESDIR}"/miredo-server.rc miredo-server
	newconfd "${FILESDIR}"/miredo-server.conf miredo-server
	newinitd "${FILESDIR}"/miredo.rc miredo
	newconfd "${FILESDIR}"/miredo.conf miredo
	insinto /etc/miredo
	doins misc/miredo-server.conf
	dodoc README NEWS ChangeLog AUTHORS THANKS TODO
}

pkg_preinst() {
	enewgroup miredo
	enewuser miredo -1 -1 /var/empty miredo
}
