# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jbigkit/jbigkit-1.4.ebuild,v 1.16 2004/03/07 19:04:10 psi29a Exp $

DESCRIPTION="JBIG-KIT implements a highly effective data compression algorithm for bi-level high-resolution images such as fax pages or scanned documents"
HOMEPAGE="http://www.cl.cam.ac.uk/~mgk25/jbigkit/"
SRC_URI="http://www.cl.cam.ac.uk/~mgk25/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 hppa ~mips"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	[ "${ARCH}" = "hppa" ] && CFLAGS="${CFLAGS} -fPIC"
	[ "${ARCH}" = "amd64" ] && append-flags -fPIC
	sed -i \
		-e "s:-O2 -W:${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	make || die "make failed"
	make test || die "tests failed"
}

src_install() {
	dolib libjbig/libjbig.a

	insinto /usr/include
	newins libjbig/jbig.h jbig.h

	# Install documentation.
	dodoc ANNOUNCE CHANGES INSTALL TODO
}
