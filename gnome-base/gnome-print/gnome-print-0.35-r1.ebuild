# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.35-r1.ebuild,v 1.1 2002/03/10 08:59:12 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME printing library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
		>=gnome-base/libglade-0.17-r1
		>=media-libs/freetype-2.0.1"

DEPEND="${RDEPEND}
		sys-devel/gettext
		sys-devel/perl
		tex? ( app-text/tetex )
     	>=app-text/ghostscript-6.50-r2
		nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	#fix Makefile not to run gnome-font-install
	cp ${S}/installer/Makefile.in ${S}/installer/Makefile.in.orig
	sed -e 's:$(PERL) $(top_srcdir)/run-gnome-font-install:echo $(top_srcdir)/run-gnome-font-install:' \
		${S}/installer/Makefile.in.orig > ${S}/installer/Makefile.in
}

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
			${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} 						\
		gnulocaledir=${D}/usr/share/locale	\
		sysconfdir=${D}/etc					\
		install || die

	insinto /usr/share/fonts
	doins ${S}/run-gnome-font-install

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	ldconfig >/dev/null 2>/dev/null
	echo ">>> Installing fonts..."
	perl /usr/share/fonts/run-gnome-font-install \
		/usr/bin/gnome-font-install \
		/usr/share/fonts /usr/share/fonts /etc >/dev/null 2>/dev/null
}

