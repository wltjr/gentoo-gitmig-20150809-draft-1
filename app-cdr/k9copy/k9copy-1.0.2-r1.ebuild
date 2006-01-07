# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.0.2-r1.ebuild,v 1.1 2006/01/07 02:21:25 metalgod Exp $

inherit eutils kde
need-kde 3.3

DESCRIPTION="k9copy is a DVD backup utility which allow the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.free.fr/"
SRC_URI="http://k9copy.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arts"
DEPEND="media-video/dvdauthor
	media-libs/libdvdread
	app-cdr/dvd+rw-tools
	>=media-video/vamps-0.98
	>=app-cdr/k3b-0.12.8"

RDEPEND=${DEPEND}

DOC="README TODO ChangeLog"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-switch.patch
}
