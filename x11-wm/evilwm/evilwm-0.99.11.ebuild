# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-0.99.11.ebuild,v 1.3 2003/02/10 02:08:15 seemant Exp $

MY_P="${PN}_${PV}.orig"
S=${WORKDIR}/${MY_P/_/-}

DESCRIPTION="A minimalist, no frills window manager for X."
SRC_URI="http://download.sourceforge.net/evilwm/${MY_P}.tar.gz"
HOMEPAGE="http://evilwm.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/x11
	motif? ( virtual/motif )"

src_unpack() {
	unpack ${A}
	cd ${S}
	
	if [ -z "`use motif`" ]
	then
		cp Makefile ${T}
		sed "s:DEFINES += -DMWM_HINTS::" \
			${T}/Makefile > Makefile
	fi
}

src_compile() {
	emake allinone || die
}

src_install () {
	exeinto /usr/bin
	doexe evilwm

	doman evilwm.1
	dodoc ChangeLog README* INSTALL TODO
}

