# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/mpqc/mpqc-2.1.2.ebuild,v 1.1 2002/10/31 19:22:55 hannes Exp $

SLOT="0"
HOMEPAGE="http://aros.ca.sandia.gov/~cljanss/mpqc/"
SRC_URI="http://aros.ca.sandia.gov/~cljanss/mpqc/distrib/${P}.tar.gz
	doc? ( http://aros.ca.sandia.gov/~cljanss/mpqc/distrib/${PN}-man-${PV}.tar.gz )"
DESCRIPTION="The Massively Parallel Quantum Chemistry Program"
LICENSE="GPL"
KEYWORDS="~x86"
IUSE="doc X"

DEPEND="sys-devel/flex
	app-sci/blas
	app-sci/lapack
	sys-devel/perl
	X?	( x11-base/xfree )"

src_compile() {
	CFLAGS_SAVE=${CFLAGS}; CXXFLAGS_SAVE=${CXXFLAGS}
	myconf="${myconf} --prefix=/usr"
	use X && myconf="${myconf} --x-includes=/usr/X11R6/include \
	  --x-libraries=/usr/X11R6/lib"
	./configure ${myconf}
	sed -e "s:^CFLAGS =.*$:CFLAGS=${CFLAGS_SAVE}:" \
	  -e "s:^FFLAGS =.*$:FFLAGS=${CFLAGS_SAVE}:" \
	  -e "s:^CXXFLAGS =.*$:CXXFLAGS=${CXXFLAGS_SAVE}:" \
	  lib/LocalMakefile > lib/LocalMakefile.foo
	mv lib/LocalMakefile.foo lib/LocalMakefile
	emake
}

src_install() {
	sed -e "s:^prefix=.*$:prefix=${D}/usr:" lib/LocalMakefile \
	  > lib/LocalMakefile.foo
	mv lib/LocalMakefile.foo lib/LocalMakefile
	use doc && doman ${WORKDIR}/${PN}-man-${PV}/man3/*
	make install install_devel install_inc
}
