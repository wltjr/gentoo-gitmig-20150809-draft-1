# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pax-utils/pax-utils-0.0.2.ebuild,v 1.4 2004/06/24 22:28:33 agriffis Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Various PaX related utils for ELF32, ELF64 binaries."
SRC_URI="mirror://gentoo/pax-utils-${PV}.tar.gz
	http://dev.gentoo.org/~solar/pax/pax-utils-${PV}.tar.gz
	http://pageexec.virtualave.net/pax-utils-${PV}.tar.gz"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened"
KEYWORDS="x86 sparc ~ppc ~hppa ~amd64 ~ia64"
LICENSE="GPL-2"
SLOT="0"

IUSE="debug"
DEPEND="virtual/glibc"

src_compile() {
	use debug && export STRIP=touch
	MAKEOPTS=-j1 emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR=${D} install
	dodoc README
}
