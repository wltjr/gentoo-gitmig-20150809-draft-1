# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.0.1-r3.ebuild,v 1.3 2002/08/01 16:07:17 seemant Exp $

inherit libtool

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Gnome Accessibility Toolkit"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="X86"

RDEPEND=">=dev-libs/glib-2.0.1"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	elibtoolize
	local myconf
	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"
	 
	econf ${myconf} --enable-debug || die

## Since glib fails with debug, we debug here too

	emake || die
}

src_install() {
	einstall || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS 
}
