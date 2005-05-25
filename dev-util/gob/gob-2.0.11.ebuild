# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-2.0.11.ebuild,v 1.3 2005/05/25 14:51:17 gustavoz Exp $

inherit gnome2

MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Preprocessor for making GTK+ objects with inline C code."
SRC_URI="http://ftp.5z.com/pub/gob/${MY_P}.tar.gz"
HOMEPAGE="http://www.5z.com/jirka/gob.html"
IUSE=""

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~hppa ~amd64 ~ppc ~alpha ~ia64"

RDEPEND=">=dev-libs/glib-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex"

DOCS="AUTHORS COPYING.generated-code ChangeLog NEWS README TODO"

USE_DESTDIR="1"
