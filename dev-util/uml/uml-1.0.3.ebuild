# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/uml/uml-1.0.3.ebuild,v 1.10 2003/02/13 12:02:37 vapier Exp $

inherit kde-base
 
DESCRIPTION="KDE 2.2 UML Drawing Utility"
SRC_URI="mirror://sourceforge/uml/${P}-1.tar.gz"
HOMEPAGE="http://uml.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86 sparc "

newdepend ">=kde-base/kdebase-2.2"

need-kde 2.2

src_compile() {
	kde_src_compile myconf
	myconf="${myconf} --mandir=${D}/usr/share/man"
	kde_src_compile configure make
}
