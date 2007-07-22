# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PGPLOT/PGPLOT-2.20.ebuild,v 1.2 2007/07/22 07:53:22 graaff Exp $

inherit perl-module

DESCRIPTION="allow subroutines in the PGPLOT graphics library to be called from Perl."
HOMEPAGE="http://search.cpan.org/~kgb/"
SRC_URI="mirror://cpan/authors/id/K/KG/KGB/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

# Tests require active X display
#SRC_TEST="do"

DEPEND="sci-libs/pgplot
	x11-base/xorg-server
	>=dev-perl/ExtUtils-F77-1.13
	dev-lang/perl"
