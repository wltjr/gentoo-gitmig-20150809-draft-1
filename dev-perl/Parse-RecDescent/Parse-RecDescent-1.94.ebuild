# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.94.ebuild,v 1.3 2003/06/24 14:57:22 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Parse/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Parse/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha"

DEPEND="dev-perl/Text-Balanced"

src_install () {
	
	perl-module_src_install
	dohtml -r tutorial
}
