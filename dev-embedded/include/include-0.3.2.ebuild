# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/include/include-0.3.2.ebuild,v 1.8 2004/06/29 13:24:49 vapier Exp $

DESCRIPTION="This is a collection of the useful independent include files for C/Assembler developers."
HOMEPAGE="http://openwince.sourceforge.net/include/"
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="sys-apps/grep
	sys-apps/gawk"
RDEPEND=""

src_install() {
	emake DESTDIR=${D} install
}
