# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gfontview/gfontview-0.5.0-r2.ebuild,v 1.1 2002/01/14 07:51:23 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Fontviewer for PostScript Tpe 1 and TrueType"
SRC_URI="http://download.sourceforge.net/gfontview/"${A}
HOMEPAGE="http://gfontview.sourceforge.net"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95
	~media-libs/freetype-1.3.1
	>=media-libs/t1lib-1.0.1
	>=x11-libs/gtk+-1.2.10-r4
	virtual/lpr
	nls? ( sys-devel/gettext )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"


src_compile() {

  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/usr $myconf
  try make
}

src_install() {
  try make prefix=${D}/usr install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
  insinto /usr/X11R6/include/X11/pixmaps/
  doins error.xpm openhand.xpm font.xpm t1.xpm tt.xpm 
}



