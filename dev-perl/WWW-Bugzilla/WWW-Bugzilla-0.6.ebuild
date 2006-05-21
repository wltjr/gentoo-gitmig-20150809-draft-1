# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Bugzilla/WWW-Bugzilla-0.6.ebuild,v 1.1 2006/05/21 18:24:40 ian Exp $

inherit perl-module

DESCRIPTION="automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/B/BM/BMC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~bmc/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/WWW-Mechanize
		<dev-perl/Class-MethodMaker-2"

DEPEND="${RDEPEND}"
