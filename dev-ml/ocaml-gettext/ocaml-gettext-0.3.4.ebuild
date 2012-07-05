# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-gettext/ocaml-gettext-0.3.4.ebuild,v 1.1 2012/07/05 01:56:16 aballier Exp $

EAPI=4

inherit findlib

DESCRIPTION="Provides support for internationalization of OCaml program"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocaml-gettext"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/676/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RDEPEND=">=dev-lang/ocaml-3.12.1
	>=dev-ml/ocaml-fileutils-0.4.0
	>=dev-ml/camomile-0.8.3
	sys-devel/gettext
	"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook-xsl-stylesheets dev-libs/libxslt )
	test? ( dev-ml/ounit )"

src_configure() {
	econf \
		--with-docbook-stylesheet="${EPREFIX}/usr/share/sgml/docbook/xsl-stylesheets/" \
		$(use_enable doc) \
		$(use_enable test)
}

src_compile() {
	emake -j1
}

src_install() {
	findlib_src_preinst
	emake -j1 DESTDIR="${D}" \
		BINDIR="${ED}/usr/bin" \
		PODIR="${ED}/usr/share/locale/" \
		DOCDIR="${ED}/usr/share/doc/${PF}" \
		MANDIR="${ED}/usr/share/man" \
		install
	dodoc CHANGELOG README THANKS TODO
}
