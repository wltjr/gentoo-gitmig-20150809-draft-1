# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/culmus/culmus-0.93.ebuild,v 1.3 2004/04/14 09:09:01 aliz Exp $

DESCRIPTION="Hebrew Type1 fonts"
SRC_URI="mirror://sourceforge/culmus/${P}.tar.gz \
http://culmus.sourceforge.net/fancy/dorian.tar.gz \
http://culmus.sourceforge.net/fancy/gladia.tar.gz \
http://culmus.sourceforge.net/fancy/ozrad.tar.gz \
http://culmus.sourceforge.net/fancy/gan.tar.gz"
HOMEPAGE="http://culmus.sourceforge.net/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2 | LICENSE-BITSTREAM"
IUSE=""

src_install () {
	dodir /usr/X11R6/lib/X11/fonts/culmus
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/culmus
	cp -a ${WORKDIR}/*.{afm,pfa}  ${D}/usr/X11R6/lib/X11/fonts/culmus
	rm ${D}/usr/X11R6/lib/X11/fonts/culmus/{CHANGES,LICENSE,LICENSE-BITSTREAM,GNU-GPL,culmus.spec}
	dodoc CHANGES LICENSE LICENSE-BITSTREAM
}

pkg_postinst() {
	einfo "Please add /usr/X11R6/lib/X11/fonts/culmus to your FontPath"
	einfo "in XF86Config to make the fonts available to all X11 apps and"
	einfo "not just those that use fontconfig (the latter category includes"
	einfo "kde 3.1 and gnome 2.2)."
	einfo "If you have fontconfig installed, run fc-cache (preferably both"
	einfo "as user and as root) to let it know about these new fonts."
}
