# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git/git-0.04.ebuild,v 1.1 2005/04/15 15:15:30 r3pek Exp $

DESCRIPTION="GIT - the stupid content tracker"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/torvalds/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/torvalds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/openssl
		sys-libs/zlib"

src_unpack() {
	unpack ${A}
	sed -i "s:CFLAGS=.*:CFLAGS=${CFLAGS}:" ${S}/Makefile
}

src_install() {
	dobin cat-file checkout-cache commit-tree diff-tree fsck-cache init-db \
		  read-tree show-diff update-cache write-tree
	dodoc README
}
