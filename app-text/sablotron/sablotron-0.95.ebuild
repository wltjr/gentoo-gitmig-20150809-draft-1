# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.95.ebuild,v 1.7 2003/02/13 09:44:38 vapier Exp $

MY_P="Sablot-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${MY_P}.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc "

DEPEND=">=dev-libs/expat-1.95.1 "

src_compile() {
	local myconf="--enable-javascript"
	use perl && myconf="${myconf} --enable-perlconnect"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall
	dodoc README* RELEASE
	dodoc src/TODO
}
