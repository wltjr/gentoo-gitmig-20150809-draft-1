# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-3.1.4-r3.ebuild,v 1.2 2012/03/11 14:12:37 ranger Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC="doc"

RUBY_FAKEGEM_EXTRADOC="CONTRIBUTING README.md"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb rails VERSION VERSION_NAME"

inherit ruby-fakegem

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://haml-lang.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

# TODO: haml has some emacs modes that it could be installing, in case
IUSE=""

# The html engine requires hpricot
ruby_add_rdepend "dev-ruby/hpricot dev-ruby/sass"

# It could use merb during testing as well, but it's not mandatory
ruby_add_bdepend "
	test? (
		virtual/ruby-test-unit
		dev-ruby/erubis
		dev-ruby/rails
		dev-ruby/ruby_parser
	)
	doc? (
		dev-ruby/yard
		dev-ruby/maruku
	)"

all_ruby_prepare() {
	# unbundle sass; remove dependency over fssm and add one over sass
	# itself.
	rm -r vendor/ || die

	pushd .. &>/dev/null
	epatch "${FILESDIR}"/${P}-sass.patch
	sed -i \
		-e '/vendor\//d' \
		metadata || die
	popd &>/dev/null
}
