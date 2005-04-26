# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hxt/hxt-5.00.ebuild,v 1.1 2005/04/26 10:59:54 kosmikus Exp $

inherit fixheadtails base eutils ghc-package

MY_PN="HXT"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A collection of tools for processing XML with Haskell"
HOMEPAGE="http://www.fh-wedel.de/~si/HXmlToolbox/"
SRC_URI="http://www.fh-wedel.de/~si/HXmlToolbox/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=virtual/ghc-6.2
	!>=virtual/ghc-6.4
	!=dev-haskell/hxt-4.02
	doc? ( >=dev-haskell/haddock-0.6-r2 )"
RDEPEND=">=virtual/ghc-6.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	base_src_unpack
	ht_fix_file "${S}/src/Makefile"
}

src_compile() {
	emake -j1 all || die "emake failed"
	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_test() {
	emake -j1 test || die "at least one test failed"
}

src_install() {
	sed -i "s:/usr/local/lib/hxt:$(ghc-libdir)/${PF}:" ${S}/src/hxt-package.conf
	sed -i "/ghc-pkg --update-package *$/d" ${S}/src/Makefile
	sed -i "/ghc-pkg --remove-package/d" ${S}/src/Makefile

	ghc-setup-pkg ${S}/src/hxt-package.conf
	emake install \
		 GHC_INSTALL_DIR="${D}$(ghc-libdir)/${PF}" \
		 || die "make install failed"

	dodoc LICENSE README
	if use doc; then
		cd ${S}/doc
		dodoc thesis.ps
		dohtml -r *
	fi
	ghc-install-pkg
}
