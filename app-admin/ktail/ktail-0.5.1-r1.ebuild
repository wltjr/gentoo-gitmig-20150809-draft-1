# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/ktail/ktail-0.5.1-r1.ebuild,v 1.5 2002/07/01 21:33:30 danarmak Exp $

inherit kde-base || die

need-kde 2

DESCRIPTION="ktail monitors multiple files and/or command output in one window."
LICENSE="GPL-2"
SRC_URI="http://www.franken.de/users/duffy1/rjakob/${P}.tar.gz"

src_unpack() {
	base_src_unpack
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}




