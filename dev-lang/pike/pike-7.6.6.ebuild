# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pike/pike-7.6.6.ebuild,v 1.7 2004/10/20 15:38:20 scandium Exp $
# Contributions by Emil Skoldberg, Fredrik Mellstrom (see ChangeLog)

inherit fixheadtails

IUSE="crypt debug doc fftw gdbm gif gtk java jpeg mysql oci8 odbc opengl pdflib postgres scanner sdl tiff truetype zlib"

S="${WORKDIR}/Pike-v${PV}"
HOMEPAGE="http://pike.ida.liu.se/"
DESCRIPTION="Pike programming language and runtime"
SRC_URI="http://pike.ida.liu.se/pub/pike/all/${PV}/Pike-v${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

DEPEND="zlib?	( sys-libs/zlib )
	pdflib? ( media-libs/pdflib )
	gdbm?	( sys-libs/gdbm )
	java?	( virtual/jdk )
	scanner? ( media-gfx/sane-backends )
	mysql?	( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	gif?	( media-libs/giflib )
	truetype? ( media-libs/freetype )
	jpeg?	( media-libs/jpeg )
	tiff?	( media-libs/tiff )
	opengl?	( virtual/opengl
		virtual/glut )
	sdl?	( media-libs/libsdl )
	gtk?	( =x11-libs/gtk+-1.2* )
	fftw?	( dev-libs/fftw )
	crypt?	( dev-libs/nettle )
	dev-libs/gmp"

src_unpack() {
	unpack ${A}
	cd ${S}

	# ht_fix_all kills autoheader stuff, so we use ht_fix_file
	find . -iname "*.sh" -or -iname "*.sh.in" -or -iname "Makefile*" | \
	while read i; do
		ht_fix_file $i
	done
}

src_compile() {

	local myconf
	use zlib  	|| myconf="${myconf} --without-zlib"
	use mysql 	|| myconf="${myconf} --without-mysql"
	use debug 	|| myconf="${myconf} --without-debug"
	use gdbm  	|| myconf="${myconf} --without-gdbm"
	use pdflib	|| myconf="${myconf} --without-libpdf"
	use java	|| myconf="${myconf} --without-java"
	use odbc	|| myconf="${myconf} --without-odbc"
	use scanner	|| myconf="${myconf} --without-sane"
	use postgres 	|| myconf="${myconf} --without-postgres"
	use oci8	|| myconf="${myconf} --without-oracle"
	use gif		|| myconf="${myconf} --without-gif"
	use truetype 	|| myconf="${myconf} --without-ttflib --without-freetype"
	use jpeg	|| myconf="${myconf} --without-jpeglib"
	use tiff	|| myconf="${myconf} --without-tifflib"
	use opengl	|| myconf="${myconf} --without-GL --without-GLUT"
	use gtk		|| myconf="${myconf} --without-GTK"
	use fftw	|| myconf="${myconf} --without-fftw"
	use crypt	|| myconf="${myconf} --without-nettle"

	emake CONFIGUREARGS="${myconf} --prefix=/usr --disable-make_conf" || die

	if use doc; then
		PATH="${S}/bin:${PATH}" make doc || die
	fi
}

src_install() {
	# the installer should be stopped from removing files, to prevent sandbox issues
	sed -i s/rm\(mod\+\"\.o\"\)\;/\{\}/ ${S}/bin/install.pike || die "Failed to modify install.pike"

	if use doc; then
		make INSTALLARGS="--traditional" buildroot="${D}" install || die
		einfo "Installing 60MB of docs, this could take some time ..."
		dohtml -r ${S}/refdoc/traditional_manual ${S}/refdoc/modref
	else
		make INSTALLARGS="--traditional" buildroot="${D}" install_nodoc || die
	fi
}
