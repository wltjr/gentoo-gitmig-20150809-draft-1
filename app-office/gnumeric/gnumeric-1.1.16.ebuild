# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.1.16.ebuild,v 1.3 2003/03/31 22:40:12 foser Exp $

#provide Xmake and Xemake
inherit virtualx libtool gnome2

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

# guile, gb and evo not supported atm, read down
#IUSE="nls libgda gb evo python guile perl"
IUSE="nls libgda python perl bonobo"

#Eye Of Gnome (media-gfx/eog) is for image support.

# FIXME : isn't bonobo optional 

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-extra/gal-1.99
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.4.12
	>=gnome-extra/libgsf-1.7.2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/bonobo-activation-1.0.2
	perl?   ( >=dev-lang/perl-5.6 )
	python? ( >=dev-lang/python-2.0 )
	libgda? ( >=gnome-extra/libgda-0.11.0 )"

# disabled during the port
#	gb?     ( ~gnome-extra/gb-0.0.17 )
#	evo?    ( >=net-mail/evolution-1.0.8 )

DEPEND="${RDEPEND}
	 nls? ( sys-devel/gettext
	 >=dev-util/intltool-0.11 )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

#	use gb \
#		&& myconf="${myconf} --with-gb" \
#		|| myconf="${myconf} --without-gb"

#	use guile \
#		&& myconf="${myconf} --with-guile" \
#		|| myconf="${myconf} --without-guile"

	use libgda \
		&& myconf="${myconf} --with-gda" \
		|| myconf="${myconf} --without-gda"
	use perl \
		&& myconf="${myconf} --with-perl" \
		|| myconf="${myconf} --without-perl"
  	use python \
		&& myconf="${myconf} --with-python" \
		|| myconf="${myconf} --without-python"

  	econf ${myconf} || die

	#the build process have to be able to connect to X
	Xemake || Xmake || die
}

src_install() {
	DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"
	gnome2_src_install DESTDIR=${D}
}

