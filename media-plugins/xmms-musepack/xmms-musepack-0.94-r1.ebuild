# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-0.94-r1.ebuild,v 1.4 2003/07/22 13:04:20 aliz Exp $

inherit flag-o-matic eutils

# Enabling -mfpath=sse can cause high-pitched whine, at least on Pentiums.
# This drops the entire flag for safety. Reports of success with any variations
# would be welcomed, but mind those eardrums!
filter-mfpmath "sse"

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://sourceforge.net/projects/mpegplus/"
SRC_URI="mirror://sourceforge/mpegplus/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.7-r15"

src_unpack() {
	unpack ${A}
	# Fix up the atrocious Makefile.
        cd ${S}; epatch ${FILESDIR}/${P}-bad-makefile.patch
}

src_compile() {
	# Makefile will use ARCH when calling gcc
	emake ARCH="${CFLAGS}" || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe ${P}.so
}
