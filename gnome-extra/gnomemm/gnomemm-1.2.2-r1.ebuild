# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Nathaniel Hirsch <nh2@njit.edu> Achim Gottinge <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnomemm/gnomemm-1.2.2-r1.ebuild,v 1.3 2002/05/27 17:27:38 drobbins Exp $


S=${WORKDIR}/${P}
DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

RDEPEND=">=x11-libs/gtkmm-1.2.8
	 >=gnome-base/ORBit-0.5.11
	 =sys-libs/db-1*"

DEPEND="${RDEPEND}"

src_unpack() {
	
	unpack ${A}

	cd ${S}/src
	patch < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	
	./configure --host=${CHOST} \
		--prefix=/usr || die

	emake || die
}

src_install() {

	make DESTDIR=${D} \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
