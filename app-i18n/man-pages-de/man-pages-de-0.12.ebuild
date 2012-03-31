# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-de/man-pages-de-0.12.ebuild,v 1.2 2012/03/31 11:13:06 ulm Exp $

EAPI=4

MY_P="${PN/-/}-${PV}"

DESCRIPTION="A somewhat comprehensive collection of Linux german man page translations"
HOMEPAGE="http://alioth.debian.org/projects/manpages-de/"
SRC_URI="http://manpages-de.alioth.debian.org/downloads/${MY_P}.tar.bz2"

LICENSE="as-is GPL-2 GPL-3 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/man"

S=${WORKDIR}/${MY_P}

src_compile() { :; }

src_install() {
	emake MANDIR="${ED}"/usr/share/man/de install
	dodoc CHANGES README

	# Remove man pages provided by other packages
	#  - shadow
	rm "${ED}"/usr/share/man/de/man1/groups.1*
}
