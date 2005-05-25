# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Temp/File-Temp-0.14.ebuild,v 1.1 2005/05/25 13:48:18 mcummings Exp $

inherit perl-module

MY_P=File-Temp-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way."
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJENNESS/${MY_P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha ppc64"
IUSE=""
