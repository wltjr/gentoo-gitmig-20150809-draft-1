# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/bzlib/bzlib-0.5.0.3.ebuild,v 1.1 2012/05/13 08:17:20 slyfox Exp $

# ebuild generated by hackport 0.2.14

EAPI="4"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the bzip2 format"
HOMEPAGE="http://hackage.haskell.org/package/bzlib"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2
		>=app-arch/bzip2-1.0"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
