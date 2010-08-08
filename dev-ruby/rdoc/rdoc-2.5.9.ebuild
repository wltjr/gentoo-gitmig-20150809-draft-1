# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-2.5.9.ebuild,v 1.2 2010/08/08 18:20:48 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt RI.txt"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eutils

DESCRIPTION="An extended version of the RDoc library from Ruby 1.8"
HOMEPAGE="http://rubyforge.org/projects/rdoc/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-solaris"
IUSE=""

RUBY_PATCHES=( "${PN}-2.5.6-ruby19.patch" )

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.5.0 )
	test? (
		>=dev-ruby/hoe-2.5.0
		virtual/ruby-minitest
	)"

all_ruby_prepare() {
	# Other packages also have use for a nonexistent directory, bug 321059
	sed -i -e 's#/nonexistent#/nonexistent_rdoc_tests#g' test/test_rdoc*.rb
}

all_ruby_install() {
	all_fakegem_install

	for bin in rdoc ri; do
		ruby_fakegem_binwrapper $bin /usr/bin/$bin-2
	done
}

each_ruby_test() {
	# `rake test' would fail when rdoc is not yet installed.
	# Setting $rdoc_rakefile fixes this.
	${RUBY} -w -Ilib:ext:bin:test \
		-e 'require "rubygems"; require	"minitest/autorun"; \
		$rdoc_rakefile = true; Dir.glob("test/test*.rb").each \
		{|t| require t }' || die "Tests failed for ${RUBY}"
}
