# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/espresso/espresso-3.0.0.ebuild,v 1.1 2011/04/20 13:03:00 ottxor Exp $

EAPI="4"

inherit autotools-utils savedconfig

DESCRIPTION="Extensible Simulation Package for Research on Soft matter"
HOMEPAGE="http://www.espressomd.org"
SRC_URI="mirror://nongnu/${PN}md/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="X doc examples fftw mpi packages test -tk"

RDEPEND="dev-lang/tcl
	X? ( x11-libs/libX11 )
	fftw? ( sci-libs/fftw:3.0 )
	mpi? ( virtual/mpi )
	tk? ( >=dev-lang/tk-8.4.18-r1 )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[-nodot]
		virtual/latex-base )"

src_prepare() {
	sed -i 's/^CFLAGS/#&/' configure.ac
	autotools-utils_src_prepare
	eautoreconf
	restore_config myconfig.h
}

src_configure() {
	myeconfargs=(
		$(use_with fftw) \
		$(use_with mpi) \
		$(use_with tk) \
		$(use_with X x)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use doc; then
		autotools-utils_src_compile doc || die "emake doc failed"
	fi
}

src_install() {
	autotools-utils_src_install

	dodoc AUTHORS NEWS README ChangeLog

	insinto /usr/share/${PN}
	doins ${AUTOTOOLS_BUILD_DIR}/myconfig-sample.h

	save_config ${AUTOTOOLS_BUILD_DIR}/src/myconfig-final.h

	if use doc; then
		newdoc doc/ug/ug.pdf user_guide.pdf
		dohtml -r ${AUTOTOOLS_BUILD_DIR}/doc/dg/html/*
		newdoc doc/tutorials/tut2/tut2.pdf tutorial.pdf
	fi

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins -r samples/*
	fi

	if use packages; then
		insinto /usr/share/${PN}/packages
		doins -r packages/*
	fi
}

pkg_postinst() {
	elog
	elog "Please read and cite:"
	elog "ESPResSo, Comput. Phys. Commun. 174(9) ,704, 2006."
	elog "http://dx.doi.org/10.1016/j.cpc.2005.10.005"
	elog
	elog "If you need more features, change"
	elog "/etc/portage/savedconfig/${CATEGORY}/${PF}"
	elog "and reemerge with USE=savedconfig"
	elog
	elog "For a full feature list see:"
	elog "/usr/share/${PN}/myconfig-sample.h"
	elog
}
