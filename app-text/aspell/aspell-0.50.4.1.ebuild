# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.50.4.1.ebuild,v 1.8 2004/05/07 22:22:59 ciaranm Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="A spell checker replacement for ispell"
HOMEPAGE="http://aspell.net/"
SRC_URI="http://aspell.net/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc ~alpha ~mips ~hppa -amd64 ia64"
IUSE="gpm"

DEPEND=">=sys-libs/ncurses-5.2
	gpm? ( sys-libs/gpm )"

src_compile() {
	if [ "${ARCH}" == "ppc" ] ; then
		export CXXFLAGS="-O2 -fsigned-char"
		export CFLAGS="${CXXFLAGS}"
	fi
	use gpm && append-ldflags -lgpm
	epatch ${FILESDIR}/01-gcc3.3-assert.patch

	elibtoolize --reverse-deps

	econf \
		--disable-static \
		--sysconfdir=/etc/aspell \
		--enable-docdir=/usr/share/doc/${PF} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	cd ${D}/usr/share/doc/${P}
	dohtml -r man-html
	rm -rf man-html
	docinto text
	dodoc man-text
	rm -rf man-text
	cd ${S}

	dodoc README* TODO

	cd examples
	make clean || die
	cd ${S}

	docinto examples
	dodoc examples/*
}

pkg_postinst() {
	einfo "You will need to install a dictionary now.  Please choose an"
	einfo "aspell-<LANG> dictionary from the app-dicts category"
	einfo "After installing an aspell dictionary for your language(s),"
	einfo "You may use the aspell-import utility to import your personal"
	einfo "dictionaries from ispell, pspell and the older aspell"
}
