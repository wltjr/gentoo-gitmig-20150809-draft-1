# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cunit/cunit-1.0.0.6.ebuild,v 1.8 2003/02/13 11:48:52 vapier Exp $

S=${WORKDIR}/CUnit-1.0-6
DESCRIPTION="CUnit - C Unit Test Framework"
# Note: Upstream authors have sucky versioning scheme. We fake.
SRC_URI="mirror://sourceforge/cunit/CUnit-1.0-6.tar.gz"
HOMEPAGE="http://cunit.sourceforge.net"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc "

src_compile() {
	./configure --prefix=/usr || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
