# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/ansi-wl-pprint/ansi-wl-pprint-0.6.4.ebuild,v 1.2 2012/08/03 12:49:31 hwoarang Exp $

# ebuild generated by hackport 0.2.14

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="The Wadler/Leijen Pretty Printer for colored ANSI terminal output"
HOMEPAGE="http://github.com/batterseapower/ansi-wl-pprint"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="<dev-haskell/ansi-terminal-0.6[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"
