# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/liveice/liveice-2000530.ebuild,v 1.6 2004/06/24 23:54:42 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Live Source Client For IceCast"
HOMEPAGE="http://star.arm.ac.uk/~spm/software/liveice.html"
SRC_URI="http://star.arm.ac.uk/~spm/software/liveice.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="media-sound/lame
	virtual/mpg123"

src_compile() {
	./configure
	emake || die
}

src_install() {
	dobin liveice
	dodoc liveice.cfg README.liveice README.quickstart README_new_mixer.txt Changes.txt
}


