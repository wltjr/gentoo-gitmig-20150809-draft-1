# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/eprog/eprog-0.0.0.20030220.ebuild,v 1.3 2003/03/11 22:54:46 agriffis Exp $

DESCRIPTION="convenience library for evas2"
HOMEPAGE="http://www.rephorm.com/rephorm/code/eprog/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE="pic"

DEPEND="virtual/x11
	virtual/glibc
	sys-devel/gcc
	>=x11-libs/evas-1.0.0.2003*
	>=x11-libs/ecore-0.0.2.2003*"

S=${WORKDIR}/${PN}

pkg_setup() {
	# the stupid gettextize script prevents non-interactive mode, so we hax it
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	econf `use_with pic` --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
