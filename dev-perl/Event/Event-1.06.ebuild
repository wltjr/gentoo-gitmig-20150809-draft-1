# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.06.ebuild,v 1.7 2006/03/15 16:43:48 corsair Exp $

inherit perl-module

DESCRIPTION="fast, generic event loop"
SRC_URI="mirror://cpan/authors/id/J/JP/JPRIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"
