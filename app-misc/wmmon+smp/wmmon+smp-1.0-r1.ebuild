# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/wmmon+smp/wmmon+smp-1.0-r1.ebuild,v 1.2 2002/07/11 06:30:17 drobbins Exp $


S=${WORKDIR}/wmmon.app
S2=${S}/wmmon
DESCRIPTION="Dockapp CPU monitor resembling Xosview, support for smp"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/wmmon+smp.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

DEPEND="virtual/x11"

src_compile() {

	cd ${S2}
	try emake

}

src_install () {

	exeinto /usr/bin
	doexe ${S2}/wmmon
	dodoc ${S}/README ${S}/COPYING ${S}/INSTALL

}
