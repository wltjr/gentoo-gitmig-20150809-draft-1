# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/qtwvdialer/qtwvdialer-0.3.1.ebuild,v 1.4 2001/06/07 21:10:33 achim Exp $

S=${WORKDIR}/QtWvDialer-${PV}
DESCRIPTION="QT Frontend for wvdial"
SRC_URI="http://private.addcom.de/toussaint/${P}.tgz"
HOMEPAGE="http://private.addcom.de/toussaint/qtwvdialer.html"

DEPEND=">=x11-libs/qt-x11-2.2.2
	>=dev-util/tmake-1.6
	net-dialup/wvdial
        sys-apps/which
        sys-apps/modutils"

RDEPEND=">=x11-libs/qt-x11-2.2.2"

src_compile() {

    cd ${S}
    export TMAKEPATH="/usr/lib/tmake/linux-g++"
    cp configure configure.orig
    sed -e "s:TMAKEPATH/\.\./\.\./bin/tmake:TMAKEPATH/../../../bin/tmake:" \
	configure.orig > configure
    try ./configure
    try make -e CFLAGS=\"$CFLAGS\"

}

src_install () {

    insinto /usr/X11R6
    dobin bin/qtwvdialer
    dodoc AUTHORS CHANGELOG COPYING README

}

