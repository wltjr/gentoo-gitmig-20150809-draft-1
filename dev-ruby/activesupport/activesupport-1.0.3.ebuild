# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-1.0.3.ebuild,v 1.2 2005/04/01 18:10:43 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/3677/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="=dev-lang/ruby-1.8*
	>=dev-ruby/rubygems-0.8.10"

