# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/dejavu/dejavu-2.0.ebuild,v 1.3 2006/02/15 13:40:43 gustavoz Exp $

inherit font

MY_P="${P/dejavu/dejavu-ttf}"

DESCRIPTION="DejaVu fonts, bitstream vera with ISO-8859-2 characters"
HOMEPAGE="http://dejavu.sourceforge.net/"
LICENSE="BitstreamVera"
SRC_URI="mirror://sourceforge/dejavu/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

# DEPEND and IUSE are defined in font.eclass
#DEPEND="X? ( virtual/x11 )"

DOCS="AUTHORS BUGS LICENSE NEWS README status.txt"
FONT_SUFFIX="ttf"
S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
