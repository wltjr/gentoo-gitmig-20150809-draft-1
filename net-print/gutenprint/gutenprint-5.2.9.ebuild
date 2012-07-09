# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gutenprint/gutenprint-5.2.9.ebuild,v 1.1 2012/07/09 09:23:05 radhermit Exp $

EAPI=4

inherit eutils multilib autotools

DESCRIPTION="Ghostscript and cups printer drivers"
HOMEPAGE="http://gutenprint.sourceforge.net"
SRC_URI="mirror://sourceforge/gimp-print/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cups foomaticdb gimp gtk nls readline ppds static-libs"

RDEPEND="app-text/ghostscript-gpl
	dev-lang/perl
	readline? ( sys-libs/readline )
	cups? ( >=net-print/cups-1.1.14 )
	foomaticdb? ( net-print/foomatic-db-engine )
	gimp? ( >=media-gfx/gimp-2.2 x11-libs/gtk+:2 )
	gtk? ( x11-libs/gtk+:2 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	gtk? ( virtual/pkgconfig )
	nls? ( sys-devel/gettext )"

RESTRICT="test"

REQUIRED_USE="gimp? ( gtk )"

DOCS=( AUTHORS ChangeLog NEWS README doc/gutenprint-users-manual.{pdf,odt} )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-5.2.4-CFLAGS.patch
	epatch "${FILESDIR}"/${PN}-5.2.8-genppd.patch # bug 382927
	sed -i -e "s:m4local:m4extra:" Makefile.am || die

	eautoreconf
}

src_configure() {
	local myconf=""

	if use cups && use ppds; then
		myconf+=" --enable-cups-ppds --enable-cups-level3-ppds"
	else
		myconf+=" --disable-cups-ppds"
	fi

	use foomaticdb \
		&& myconf+=" --with-foomatic3" \
		|| myconf+=" --without-foomatic"

	econf \
		--enable-test \
		--with-ghostscript \
		--disable-translated-cups-ppds \
		$(use_enable gtk libgutenprintui2) \
		$(use_with gimp gimp2) \
		$(use_with gimp gimp2-as-gutenprint) \
		$(use_with cups) \
		$(use_enable nls) \
		$(use_with readline) \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	default

	dohtml doc/FAQ.html
	dohtml -r doc/gutenprintui2/html
	rm -fR "${ED}"/usr/share/gutenprint/doc
	if ! use gtk; then
		rm -f "${ED}"/usr/$(get_libdir)/pkgconfig/gutenprintui2.pc
		rm -rf "${ED}"/usr/include/gutenprintui2
	fi

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}

pkg_postinst() {
	if [ "${ROOT}" == "/" ] && [ -x /usr/sbin/cups-genppdupdate ]; then
		elog "Updating installed printer ppd files"
		elog $(/usr/sbin/cups-genppdupdate)
	else
		elog "You need to update installed ppds manually using cups-genppdupdate"
	fi
}
