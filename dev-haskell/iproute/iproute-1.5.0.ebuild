# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/iproute/iproute-1.5.0.ebuild,v 1.1 2015/08/01 16:46:52 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.4.5

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="IP Routing Table"
HOMEPAGE="http://www.mew.org/~kazu/proj/iproute/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/appar:=[profile?]
	dev-haskell/byteorder:=[profile?]
	dev-haskell/network:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/doctest-0.9.3
		dev-haskell/hspec
		dev-haskell/quickcheck
		dev-haskell/safe )
"
