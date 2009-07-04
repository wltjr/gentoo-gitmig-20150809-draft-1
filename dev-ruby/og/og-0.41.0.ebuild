# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/og/og-0.41.0.ebuild,v 1.2 2009/07/04 09:30:09 graaff Exp $

inherit ruby gems

DESCRIPTION="Og (ObjectGraph) is a powerfull object-relational mapping library."
HOMEPAGE="http://www.nitroproject.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE="mysql postgres sqlite kirbybase"

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/glue-${PV}
	mysql? ( >=dev-ruby/mysql-ruby-2.7.2 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )
	sqlite? ( >=dev-ruby/sqlite3-ruby-1.2.1 )
	kirbybase? ( >=dev-ruby/kirbybase-2.3 )"
