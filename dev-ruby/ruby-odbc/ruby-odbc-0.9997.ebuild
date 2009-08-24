# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-odbc/ruby-odbc-0.9997.ebuild,v 1.1 2009/08/24 19:45:06 graaff Exp $

inherit ruby
DESCRIPTION="RubyODBC - For accessing ODBC data sources from the Ruby language"
HOMEPAGE="http://www.ch-werner.de/rubyodbc/"
SRC_URI="http://www.ch-werner.de/rubyodbc/${P}.tar.gz"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
USE_RUBY="ruby18"
IUSE="unicode"

DEPEND=">=dev-db/unixODBC-2.0.6"
RDEPEND="${DEPEND}"

src_compile() {
	ruby extconf.rb
	emake
	if use unicode ; then
		ruby -Cutf8 extconf.rb
		emake -C utf8
	fi
}

src_install() {
	ruby_einstall

	if use unicode ; then
		ruby_einstall -C utf8
	fi

	dodoc README
	dodoc ChangeLog
	dohtml  doc/odbc.html
}
