# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/va-systemimager-client/va-systemimager-client-1.4.0.ebuild,v 1.17 2004/06/24 21:41:48 agriffis Exp $

DESCRIPTION="VA SystemImager software automates the installation of Linux to masses of similar machines."
SRC_URI="mirror://sourceforge/systemimager/${P}.tar.bz2"
HOMEPAGE="http://systemimager.org/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 sparc ppc"

src_install() {
	DESTDIR=${D} ./installclient --quiet || die
}
