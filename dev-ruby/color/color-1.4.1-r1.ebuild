# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color/color-1.4.1-r1.ebuild,v 1.2 2011/09/18 12:17:44 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Colour management with Ruby"
HOMEPAGE="http://color.rubyforge.org/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.5.0 )
	test? (
		>=dev-ruby/hoe-2.5.0
		virtual/ruby-test-unit
	)"
