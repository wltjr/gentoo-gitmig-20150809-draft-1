# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cryptlib/cryptlib-3.1.ebuild,v 1.2 2005/01/21 23:18:22 dragonheart Exp $

S=${WORKDIR}
MY_PV=${PV/./}
DESCRIPTION="Powerful security toolkit for adding encryption to software"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip
	doc? ( ftp://ftp.franken.de/pub/crypt/cryptlib/manual.pdf )"

LICENSE="Sleepycat"
KEYWORDS="~x86"
SLOT="0"

IUSE="static"

DEPEND=">=sys-apps/sed-4
	app-arch/zip"
RDEPEND=""

src_unpack() {
	# Can't use unpack because we need the '-a' option
	unzip -qoa ${DISTDIR}/cl${MY_PV}.zip
	sed -i \
		-e 's/make endian/$(MAKE) endian/' \
		-e 's/make TARGET/$(MAKE) TARGET/' makefile || \
			die "sed makefile failed"
}

src_compile() {
	export SCFLAGS="-fPIC -c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	export CFLAGS="-c -D__UNIX__ -DNDEBUG -I. ${CFLAGS}"
	if useq static ; then
		emake CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || \
			die "emake static failed"
	fi
	emake shared CFLAGS="${CFLAGS}" SCFLAGS="${SCFLAGS}" || \
		die "emake shared failed"
}

src_install() {
	dolib.so libcl.so*              || die "dolib.so failed"
	if useq static ; then
		dolib.a libcl.a             || die "dolib.a failed"
	fi
	insinto /usr/include
	doins cryptlib.h                || die "doins failed"
	dodoc README                    || die "dodoc failed"
	if useq doc ; then
		dodoc ${DISTDIR}/manual.pdf || die "dodoc failed (manual.pdf)"
	fi
}
