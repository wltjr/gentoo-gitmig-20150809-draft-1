# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mime-types/mime-types-1.0.ebuild,v 1.8 2004/06/24 22:24:23 agriffis Exp $

DESCRIPTION="Provides mime.types file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc amd64 ia64 ~hppa"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /etc
	doins mime.types
}
