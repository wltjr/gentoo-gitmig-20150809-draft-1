# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrootuid/chrootuid-1.3.ebuild,v 1.3 2004/06/24 21:24:15 agriffis Exp $

IUSE=""

MY_P="${P/-/}"

DESCRIPTION="Chrootuid makes it easy to run a network service at low privilege level and with restricted file system access."
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_compile() {
	# Add in our own custom CFLAGS
	sed -i "s/CFLAGS\t=/CFLAGS = ${CFLAGS} #/" Makefile
	emake || die "emake failed :'("
}

src_install() {
	dobin chrootuid
	doman chrootuid.1
	dodoc README chrootuid_license
}
