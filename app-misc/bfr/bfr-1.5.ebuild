# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfr/bfr-1.5.ebuild,v 1.5 2004/06/07 05:20:33 dragonheart Exp $

DESCRIPTION="Buffer (bfr) is a general-purpose command-line pipe buffer"
HOMEPAGE="http://www.glines.org:8000/software/buffer.html"
SRC_URI="http://www.glines.org:8000/bin/pk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86"

DEPEND=""

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS COPYING INSTALL Changelog NEWS README TODO
}
