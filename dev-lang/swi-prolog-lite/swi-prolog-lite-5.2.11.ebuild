# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog-lite/swi-prolog-lite-5.2.11.ebuild,v 1.7 2005/04/01 02:41:29 josejx Exp $

IUSE="readline static"

S="${WORKDIR}/pl-${PV}"
DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://www.swi.psy.uva.nl/cgi-bin/nph-download/SWI-Prolog/pl-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~sparc ~ppc"

DEPEND="sys-libs/ncurses
	sys-apps/gawk
	sys-apps/sed
	sys-devel/binutils
	readline? ( sys-libs/readline )"

src_compile() {
	cd ${S}/src
	#S="${S}/src"

	local myconf
	use readline || myconf="${myconf} --disable-readline"
	use static && myconf="${myconf} --disable-shared"

	econf ${myconf} --enable-mt || die "econf failed"
	MAKEOPTS="-j1" emake || die "make failed"
}

src_install() {
	cd ${S}/src
	einstall

	cd ${S}
	dodoc ANNOUNCE ChangeLog INSTALL INSTALL.notes PORTING README VERSION
}
