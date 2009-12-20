# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dbd-sqlite3/dbd-sqlite3-1.2.5.ebuild,v 1.4 2009/12/20 12:42:57 graaff Exp $

inherit "ruby"

DESCRIPTION="The SQLite 3 database driver (DBD) for Ruby/DBI"
HOMEPAGE="http://ruby-dbi.rubyforge.org"
SRC_URI="mirror://rubyforge/ruby-dbi/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="
	>=dev-ruby/ruby-dbi-0.4.2
	>=dev-ruby/sqlite3-ruby-1.2.4"

USE_RUBY="ruby18"

src_test() {
	elog "The tests require additional configuration."
	elog "You will find them in /usr/share/${PN}/test/"
	elog "Be sure to read the file called DBD_TESTS."
}

src_install() {
	ruby setup.rb install \
		--prefix="${D}" || die "setup.rb install failed"

	if use test; then
		dodir /usr/share/${PN}
		cp -pPR test "${D}/usr/share/${PN}" || die "couldn't copy tests"
	fi
}
