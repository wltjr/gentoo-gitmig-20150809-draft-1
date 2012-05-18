# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krossruby/krossruby-4.8.3.ebuild,v 1.2 2012/05/18 06:53:45 josejx Exp $

EAPI=4

KMNAME="kross-interpreters"
KMMODULE="ruby"
KDE_SCM="git"

USE_RUBY="ruby18"
# No ruby19 for three reasons:
# 1) it does not build (yet) - will likely be solved soon
# 2) cmake bails when configuring twice or more - solved with CMAKE_IN_SOURCE_BUILD=1
# 3) the ebuild can only be installed for one ruby variant, otherwise the compiled
#    files with identical path+name will overwrite each other - difficult :(

inherit kde4-meta ruby-ng

DESCRIPTION="Kross scripting framework: Ruby interpreter"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND=""
RDEPEND=""

# Split from kdebindings-ruby in 4.7
add_blocker kdebindings-ruby

pkg_setup() {
	ruby-ng_pkg_setup
	kde4-meta_pkg_setup
}

src_unpack() {
	local S="${WORKDIR}/${P}"
	kde4-meta_src_unpack

	cd "${WORKDIR}"
	mkdir all
	mv ${P} all/ || die "Could not move sources"
}

all_ruby_prepare() {
	kde4-meta_src_prepare
}

each_ruby_configure() {
	local CMAKE_USE_DIR=${S}
	local mycmakeargs=(
		-DRUBY_LIBRARY=$(ruby_get_libruby)
		-DRUBY_INCLUDE_DIR=$(ruby_get_hdrdir)
		-DRUBY_EXECUTABLE=${RUBY}
	)
	kde4-meta_src_configure
}

each_ruby_compile() {
	local CMAKE_USE_DIR=${S}
	kde4-meta_src_compile
}

each_ruby_install() {
	local CMAKE_USE_DIR=${S}
	kde4-meta_src_install
}
