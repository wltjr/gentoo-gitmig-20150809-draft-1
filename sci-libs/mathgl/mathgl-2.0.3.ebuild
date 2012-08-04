# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mathgl/mathgl-2.0.3.ebuild,v 1.2 2012/08/04 18:10:02 bicatali Exp $

EAPI=4

WX_GTK_VER=2.8

inherit cmake-utils eutils python wxwidgets multilib

DESCRIPTION="Math Graphics Library"
HOMEPAGE="http://mathgl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz mirror://sourceforge/${PN}/STIX_font.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc double-precision fltk gif glut gsl hdf hdf5 jpeg mpi octave opengl pdf
	png python qt4 static-libs threads wxwidgets zlib"

LANGS="ru"
for l in ${LANGS}; do
	IUSE+=" linguas_${l}"
done

RDEPEND="
	!sci-visualization/udav
	virtual/opengl
	fltk? ( x11-libs/fltk:1 )
	gif? ( media-libs/giflib )
	glut? ( media-libs/freeglut )
	gsl? ( sci-libs/gsl )
	hdf? ( sci-libs/hdf )
	hdf5? ( >=sci-libs/hdf5-1.8[mpi=] )
	jpeg? ( virtual/jpeg )
	octave? ( >=sci-mathematics/octave-3.4.0 )
	pdf? ( media-libs/libharu )
	png? ( media-libs/libpng )
	python? ( dev-python/numpy )
	qt4? ( x11-libs/qt-gui:4 )
	wxwidgets? ( x11-libs/wxGTK:2.8 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	doc? ( app-text/texi2html virtual/texi2dvi )
	octave? ( dev-lang/swig )
	python? ( dev-lang/swig )"

REQUIRED_USE="mpi? ( hdf5 ) png? ( zlib )"

pkg_setup() {
	if use mpi; then
		export CC=mpicc
		export CXX=mpicxx
	fi
	use python && python_pkg_setup
	use wxwidgets && wxwidgets_pkg_setup
}

src_unpack() {
	unpack ${A}
	[[ -d "${S}"/fonts ]] || mkdir "${S}"/fonts
	cd "${S}"/fonts
	unpack STIX_font.tgz
}

src_prepare() {
	# fix for location of hdf headers
	sed -i -e 's:hdf/::g' src/data_io.cpp || die
	# bored of reporting bad libdir upstream
	sed -i \
		-e '/DESTINATION/s:lib$:lib${LIB_SUFFIX}:g' \
		*/CMakeLists.txt || die
	echo "" > lang/install.m || die
	epatch "${FILESDIR}"/${P}-fix-hardcoded-paths.patch
}

src_configure() {
	local mycmakeargs=(
		-DHDF4_INCLUDE_DIR="${EPREFIX}/usr/include"
		$(cmake-utils_use doc enable-doc)
		$(cmake-utils_use double-precision enable-double)
		$(cmake-utils_use fltk enable-fltk)
		$(cmake-utils_use gif enable-gif)
		$(cmake-utils_use glut enable-glut)
		$(cmake-utils_use gsl enable-gsl)
		$(cmake-utils_use hdf enable-hdf4)
		$(cmake-utils_use hdf5 enable-hdf5_18)
		$(cmake-utils_use jpeg enable-jpeg)
		$(cmake-utils_use mpi enable-mpi)
		$(cmake-utils_use octave enable-octave)
		$(cmake-utils_use opengl enable-opengl)
		$(cmake-utils_use pdf enable-pdf)
		$(cmake-utils_use png enable-png)
		$(cmake-utils_use threads enable-pthread)
		$(cmake-utils_use python enable-python)
		$(cmake-utils_use wxwidgets enable-wx)
		$(cmake-utils_use zlib enable-zlib)
	)
	cmake-utils_src_configure
	# to whoever cares: TODO: do for multiple python ABI
	if use python; then
		sed -i \
			-e "s:--prefix=\(.*\) :--prefix=\$ENV{DESTDIR}\1 :" \
			"${CMAKE_BUILD_DIR}"/lang/cmake_install.cmake || die
		# fix location of numpy
		use python && append-cppflags \
			-I$(echo "import numpy; print numpy.get_include()" | "$(PYTHON)" - 2>/dev/null)
	fi

}

src_install() {
	cmake-utils_src_install
	dodoc README* *.txt AUTHORS
	use static-libs || rm "${ED}"/usr/$(get_libdir)/*.a
	if use qt4 ; then
		local lang
		insinto /usr/share/udav
		for lang in ${LANGS} ; do
			use linguas_${lang} && doins udav/udav_${lang}.qm
		done
	fi
	if use octave ; then
		insinto /usr/share/${PN}/octave
		doins "${CMAKE_BUILD_DIR}"/lang/${PN}.tar.gz
	fi
}

pkg_postinst() {
	if use octave; then
		octave <<-EOF
		pkg install ${EROOT}/usr/share/${PN}/octave/${PN}.tar.gz
		EOF
	fi
	use python && python_mod_optimize ${PN}.py
}

pkg_prerm() {
	if use octave; then
		octave <<-EOF
		pkg uninstall ${PN}
		EOF
	fi
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}.py
}
