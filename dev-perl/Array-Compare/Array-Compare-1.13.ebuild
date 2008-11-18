# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Compare/Array-Compare-1.13.ebuild,v 1.15 2008/11/18 14:24:08 tove Exp $

inherit perl-module

DESCRIPTION="Perl extension for comparing arrays."
HOMEPAGE="http://search.cpan.org/~davecross"
SRC_URI="mirror://cpan/authors/id/D/DA/DAVECROSS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND=">=virtual/perl-Module-Build-0.28
	${RDEPEND}"
