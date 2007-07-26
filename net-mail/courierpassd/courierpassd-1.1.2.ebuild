# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/courierpassd/courierpassd-1.1.2.ebuild,v 1.1 2007/07/26 23:05:10 jurek Exp $

inherit eutils
DESCRIPTION="Courierpassd is a utility for changing a user's password from across a network"
HOMEPAGE="http://www.arda.homeunix.net/"
SRC_URI="http://www.arda.homeunix.net/store/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xinetd"

DEPEND="net-libs/courier-authlib
		xinetd? ( sys-apps/xinetd )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	if use xinetd; then
		insinto /etc/xinetd.d
		doins ${FILESDIR}/courierpassd || die "doins failed"
	fi

	dodoc README AUTHORS COPYING ChangeLog INSTALL NEWS || die "dodoc failed"
}
