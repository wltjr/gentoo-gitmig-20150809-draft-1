# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/socket++/socket++-1.12.12.ebuild,v 1.2 2005/01/10 11:13:50 ka0ttic Exp $

DESCRIPTION="C++ Socket Library"
HOMEPAGE="http://www.linuxhacker.at/socketxx/"
SRC_URI="http://www.linuxhacker.at/linux/downloads/src/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug doc"

DEPEND="=sys-devel/automake-1.7*
	=sys-devel/autoconf-2.59*
	sys-devel/libtool
	sys-apps/texinfo"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	WANT_AUTOMAKE=1.7 WANT_AUTOCONF=2.5  ./autogen || die "./autogen failed"
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		cd ${S}/doc
		einfo "Building HTML documentation"
		# the 'html' target in both ${S}/Makefile and ${S}/doc/Makefile
		# do indeed exist (and succeed when run manually), but fail when
		# 'make html' is done here, so we call makeinfo ourselves.
		makeinfo --html -I . -o html socket++.texi || die "makeinfo failed"
	fi
}

src_test() {
	cd ${S}/test
	make check || die "make check failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README* THANKS || die "dodoc failed"

	if use doc ; then
		dohtml doc/html/* || die "dohtml failed"
	fi
}
