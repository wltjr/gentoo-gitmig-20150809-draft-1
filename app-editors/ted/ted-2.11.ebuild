# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ted/ted-2.11.ebuild,v 1.15 2004/04/25 22:05:10 agriffis Exp $

DESCRIPTION="X-based rich text editor"
HOMEPAGE="http://www.nllgg.nl/Ted"
SRC_URI="ftp://ftp.nluug.nl/pub/editors/ted/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="x11-libs/openmotif
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.3"

S="${WORKDIR}/Ted-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}/Ted
	mv makefile.in makefile.in.orig
	sed 's@^CFLAGS=@CFLAGS= -DDOCUMENT_DIR=\\"/usr/share/doc/${PF}/Ted/\\"@' makefile.in.orig > makefile.in
}

src_compile() {
	for dir in Ted tedPackage appFrame appUtil ind bitmap libreg; do
		cd ${S}/${dir}
		econf --cache-file=../config.cache || die "econf failed"
	done

	# The makefile doesn't really allow parallel make, but it does
	# no harm either.
	cd ${S}
	emake DEF_AFMDIR=-DAFMDIR=\\\"/usr/share/Ted/afm\\\" \
		DEF_INDDIR=-DINDDIR=\\\"/usr/share/Ted/ind\\\" \
		package.shared || die "couldnt emake"
}

src_install() {
	cd ${WORKDIR}
	cd ..

	mkdir temp/pkg
	cd temp/pkg || die "Couldn't cd to package"
	tar --use=gzip -xvf ../../work/Ted-2.11/tedPackage/Ted*.tar.gz || die "couldnt unpack tedPackage/Ted*.tar.gz"

	dodir /usr/share/Ted
	cp -R temp/pkg/afm ${D}/usr/share/Ted/afm || die "couldnt cp temp/pkg/afm"
	cp -R temp/pkg/ind ${D}/usr/share/Ted/ind || die "couldnt cp temp/pkg/ind"

	exeinto /usr/bin
	doexe temp/pkg/bin/* || die "couldnt doexe temp/pkg/bin/*"

	mkdir dodir /usr/share/doc/${P}
	cp -R temp/pkg/Ted ${D}/usr/share/doc/${P} || die "couldnt cp temp/pkg/Ted"

	rm -rf temp
}
