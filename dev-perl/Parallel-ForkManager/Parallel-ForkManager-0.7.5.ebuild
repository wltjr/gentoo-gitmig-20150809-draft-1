# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parallel-ForkManager/Parallel-ForkManager-0.7.5.ebuild,v 1.4 2005/04/22 12:39:41 blubb Exp $

inherit perl-module

DESCRIPTION="Parallel ForkManager module"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DL/DLUX/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Parallel::ForkManager"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"
IUSE=""

mydoc="TODO"

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}
