# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.16.0.ebuild,v 1.9 2009/10/26 18:12:51 armin76 Exp $

inherit gnome2

DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc examples test"

RDEPEND=">=dev-cpp/glibmm-2.19
	>=x11-libs/gtk+-2.15.5
	>=dev-cpp/cairomm-1.2.2
	>=dev-cpp/pangomm-2.14.0
	>=dev-libs/atk-1.9.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS CHANGES ChangeLog PORTING NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-api-atkmm
		$(use_enable doc docs)
		$(use_enable examples demos)"
}

src_unpack() {
	gnome2_src_unpack

	if ! use test; then
		# don't waste time building tests
		sed -i 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' Makefile.in || die "sed failed"
	fi
}
