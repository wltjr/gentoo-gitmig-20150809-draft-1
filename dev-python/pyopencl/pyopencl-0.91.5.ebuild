# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopencl/pyopencl-0.91.5.ebuild,v 1.3 2010/12/12 19:33:31 spock Exp $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

EAPI="2"

inherit distutils

DESCRIPTION="Python wrapper for OpenCL"
HOMEPAGE="http://mathema.tician.de/software/pyopencl"
SRC_URI="http://pypi.python.org/packages/source/p/pyopencl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples opengl"

RDEPEND="dev-python/pytools
	dev-libs/boost[python]
	>=dev-python/numpy-1.0.4
	>=dev-util/nvidia-cuda-toolkit-3.0"
DEPEND="${RDEPEND}"

src_configure()
{
	if use opengl; then
		myconf="${myconf} --cl-enable-gl"
	fi

	./configure.py --boost-python-libname=boost_python-mt \
		--boost-thread-libname=boost_thread-mt --boost-compiler=gcc \
		${myconf}
}

src_install()
{
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}

pkg_postinst()
{
	distutils_pkg_postinst
	if use examples; then
		elog "Some of the examples provided by this package require dev-python/matplotlib."
	fi
}
