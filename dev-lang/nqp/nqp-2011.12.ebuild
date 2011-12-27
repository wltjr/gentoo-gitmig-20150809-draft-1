# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqp/nqp-2011.12.ebuild,v 1.1 2011/12/27 07:28:40 patrick Exp $

EAPI=3

inherit eutils multilib

PARROT_VERSION="3.9.0"

DESCRIPTION="Not Quite Perl, a Perl 6 bootstrapping compiler"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://github.com/perl6/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/parrot-${PARROT_VERSION}[unicode]"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_prepare() {
	cd "${WORKDIR}"
	ln -s * "${S}" || die
	cd "${S}"
	echo "${PV}" > VERSION
}

src_configure() {
	perl Configure.pl || die
}

src_test() {
	emake -j1 test || die
}

src_install() {
	emake DESTDIR="${ED}" install || die

	dodoc CREDITS README || die

	if use doc; then
		dodoc docs/* || die
	fi
}
