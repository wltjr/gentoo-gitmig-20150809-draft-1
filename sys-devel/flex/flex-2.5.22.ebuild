# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.22.ebuild,v 1.1 2002/10/21 00:11:21 azarah Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="GNU lexical analyser generator"
#SRC_URI="ftp://ftp.gnu.org/gnu/non-gnu/flex/flex-2.5.4a.tar.gz"
SRC_URI="ftp://ftp.uncg.edu/people/wlestes/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"
#HOMEPAGE="http://astro.temple.edu/~john43/flex/"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"


src_compile() {
	myconf=""

	use nls || myconf="--disable-nls"

	econf ${myconf} || die

    if [ -z "`use static`" ]
    then
        emake || die
    else
        emake LDFLAGS=-static || die
    fi
}

src_install() {
    einstall || die
	
    if [ -z "`use build`" ]
    then
        dodoc AUTHORS COPYING ChangeLog NEWS ONEWS README* RoadMap THANKS TODO
    else
        rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib
    fi

	dosym flex /usr/bin/lex
}

