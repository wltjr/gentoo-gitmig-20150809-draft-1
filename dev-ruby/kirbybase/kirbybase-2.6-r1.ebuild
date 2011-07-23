# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kirbybase/kirbybase-2.6-r1.ebuild,v 1.2 2011/07/23 11:25:00 maekke Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_NAME="KirbyBase"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="changes.txt kirbybaserubymanual.html README"

inherit ruby-fakegem

DESCRIPTION="A simple Ruby DBMS that stores data in plaintext files."
HOMEPAGE="http://www.netpromi.com/kirbybase_ruby.html"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 x86"
IUSE=""

each_ruby_test() {
	${RUBY} -Ctest tc_local_db.rb || die
	${RUBY} -Ctest tc_local_table.rb || die
	${RUBY} -Ctest ts_local.rb || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples images || die
}
