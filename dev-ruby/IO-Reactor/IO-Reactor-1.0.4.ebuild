# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/IO-Reactor/IO-Reactor-1.0.4.ebuild,v 1.2 2012/03/08 15:25:33 ranger Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_DOCDIR="docs/html"
RUBY_FAKEGEM_EXTRADOC="ChangeLog README"

inherit ruby-fakegem

MY_P="io-reactor-${PV}"

DESCRIPTION="IO Reactor for event-driven multiplexed IO in a single thread"
HOMEPAGE="http://www.deveiate.org/projects/IO-Reactor/"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ppc64 ~x86 ~x86-fbsd"
IUSE="examples"

ruby_add_bdepend test dev-ruby/rspec

all_ruby_install() {
	all_fakegem_install

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
