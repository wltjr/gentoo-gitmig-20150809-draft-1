# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-mysql/Class-DBI-mysql-0.23.ebuild,v 1.6 2005/01/30 02:43:03 luckyduck Exp $

inherit perl-module

DESCRIPTION="Extensions to Class::DBI for MySQL"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE=""

#Can't put tests here because they require interaction with the DB

DEPEND="dev-perl/Class-DBI
		dev-perl/Test-Simple
		dev-perl/DBD-mysql"
