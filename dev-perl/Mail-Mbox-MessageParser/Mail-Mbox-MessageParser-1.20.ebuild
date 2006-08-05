# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Mbox-MessageParser/Mail-Mbox-MessageParser-1.20.ebuild,v 1.14 2006/08/05 13:49:47 mcummings Exp $

inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"
SRC_URI="mirror://cpan/authors/id/D/DC/DCOPPIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~dcoppit/${P}/"
IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc amd64 sparc"

DEPEND="dev-perl/FileHandle-Unget
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_compile() {
	echo "" | perl-module_src_compile
}

