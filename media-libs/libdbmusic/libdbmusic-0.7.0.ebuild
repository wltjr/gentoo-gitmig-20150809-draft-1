# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdbmusic/libdbmusic-0.7.0.ebuild,v 1.1 2003/07/19 06:28:23 jje Exp $

inherit kde-base
myconf="$myconf --host=${CHOST} --prefix=${PREFIX} --with-pqdir=/usr/include/ --with-qtdir=/usr/qt/3/ --with-kdedir=${KDEDIR}"
need-kde 3

IUSE=""
LICENSE="GPL-2"
DESCRIPTION="libmusicdb is a wrapper library allowing you to \
interface a libdbmusic database to any program. "
SRC_URI="mirror://sourceforge/kmusicdb/${P}.tar.gz"
HOMEPAGE="http://kmusicdb.sourceforge.net/"
KEYWORDS="~x86"

newdepend ">=dev-db/postgresql-7.2.0
	>=dev-libs/libpq++-4.0-r1"



