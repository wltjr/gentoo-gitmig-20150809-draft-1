# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zsync/zsync-0.6.2.ebuild,v 1.2 2011/02/09 22:02:26 robbat2 Exp $

EAPI=3
inherit autotools eutils

DESCRIPTION="Partial/differential file download client over HTTP which uses the rsync algorithm"
HOMEPAGE="http://zsync.moria.org.uk/"

ZLIB_PV=1.2.3
ZLIB_P="zlib-${ZLIB_PV}"
SRC_URI="http://zsync.moria.org.uk/download/${P}.tar.bz2
	http://www.gzip.org/zlib/${ZLIB_P}.tar.bz2
	http://www.zlib.net/${ZLIB_P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ZLIB_S="${WORKDIR}/${ZLIB_P}"

src_prepare() {
	# Move old zlib-1.2.11 out the way
	cd "${S}"
	mv "${S}"/zlib zlib-1.2.11-modified

	cd "${ZLIB_S}"
	# I am not sure how many other zlib patches we will need to port as well
	# This covers the security vuln in 1.2.11
	epatch "${FILESDIR}"/${P}-${ZLIB_P}-support.patch
	rm -f Makefile

	cd "${S}"
	cp -a "${ZLIB_S}" "${ZLIB_P}-modified"
	ln -s "${ZLIB_P}-modified" zlib

	eautoreconf
}

src_install() {
	dobin zsync zsyncmake
	dodoc NEWS README
	doman doc/zsync.1 doc/zsyncmake.1
}
