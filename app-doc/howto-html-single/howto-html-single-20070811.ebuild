# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-html-single/howto-html-single-20070811.ebuild,v 1.1 2007/08/11 19:15:42 dirtyepic Exp $

# Download from
# www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/Linux-html-single-HOWTOs-${PV}.tar.bz2
# and mirror it.

DESCRIPTION="The LDP howtos, html single-page format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-html-single-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RESTRICT="strip binchecks"

S=${WORKDIR}

src_install() {
	insinto /usr/share/doc/howto/html-single
	doins -r * || die
}
