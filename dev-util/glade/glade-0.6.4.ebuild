# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-0.6.4.ebuild,v 1.20 2005/01/21 04:39:27 joem Exp $

inherit eutils

DESCRIPTION="GUI designer for GTK+/GNOME-1"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/glade/${P}.tar.gz"
HOMEPAGE="http://glade.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64"
IUSE="bonobo debug gnome nls"

RDEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${DEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	epatch ${FILESDIR}/${P}-autogen.sh.patch

	econf \
		--disable-gnome-db \
		`use_enable gnome` \
		`use_with bonobo` \
		`use_enable nls` \
		`use_enable debug` \
		${myconf}  || die

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
