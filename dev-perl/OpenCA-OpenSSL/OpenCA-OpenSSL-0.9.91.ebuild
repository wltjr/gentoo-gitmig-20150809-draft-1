# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-OpenSSL/OpenCA-OpenSSL-0.9.91.ebuild,v 1.13 2005/10/02 13:06:08 agriffis Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::SSL Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc s390 sparc x86"
IUSE=""

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/X500-DN
	dev-libs/openssl"
