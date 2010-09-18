# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coderay/coderay-0.9.4.ebuild,v 1.1 2010/09/18 14:53:30 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="lib/README"

inherit ruby-fakegem

DESCRIPTION="A Ruby library for syntax highlighting."
HOMEPAGE="http://coderay.rubychan.de/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# Redcloth is optional but automagically tested, so we add this
# dependency to ensure that we get at least a version that works: bug
# 330621. We use this convoluted way because redcloth isn't available
# yet for jruby.
USE_RUBY=ruby18 ruby_add_bdepend "ruby_targets_ruby18 test" ">=dev-ruby/redcloth-4.2.2"
USE_RUBY=ruby19 ruby_add_bdepend "ruby_targets_ruby19 test" ">=dev-ruby/redcloth-4.2.2"
USE_RUBY=ree18 ruby_add_bdepend "ruby_targets_ree18 test" ">=dev-ruby/redcloth-4.2.2"
