# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-1.0.ebuild,v 1.2 2003/07/29 13:48:22 lanius Exp $

DESCRIPTION="Provides a virtual printer for CUPS to produce PDF files."
HOMEPAGE="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/"
MY_P="${PN}_${PV/_/}"
SRC_URI="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="net-print/cups"

S="${WORKDIR}/${MY_P}"

src_compile() {
	gcc ${CFLAGS} -o cups-pdf cups-pdf.c || die "Compilation failed."
}

src_install () {
	dodir /usr/lib/cups/backend
	exeinto /usr/lib/cups/backend
	doexe cups-pdf

	dodir /usr/share/cups/model
	insinto /usr/share/cups/model
	doins PostscriptColor.ppd.gz

	dodoc ${FILESDIR}/README.gentoo
}

pkg_postinst () {
	einfo "You will find some informations about cups-pdf in this file:"
	einfo "/usr/share/doc/${PF}/README.gentoo.gz"
}
