# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ariadne/ariadne-1.3-r1.ebuild,v 1.4 2006/01/21 17:26:17 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Protein sequences and profiles comparison"
LICENSE="as-is"
HOMEPAGE="http://www.well.ox.ac.uk/ariadne/"
SRC_URI="http://www.well.ox.ac.uk/${PN}/${P}.tar.Z"

SLOT="0"
IUSE=""
KEYWORDS="x86"

DEPEND=">=sci-biology/ncbi-tools-20041020-r1"

S="${WORKDIR}/SRC-${PV}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	sed -e "s/CC = gcc/CC = $(tc-getCC)/" \
		-e "s/OPTIMISE = -O2/OPTIMISE = ${CFLAGS}/" \
		-i Makefile || die
	sed -e "s/blosum62/BLOSUM62/" -i prospero.c || die
}

src_compile() {
	emake || die
}

src_install() {
	dobin Linux/{ariadne,prospero} || die
	dolib Linux/libseq.a || die
	insinto /usr/include/${PN}
	doins Include/*.h || die
	dodoc README || die
}
