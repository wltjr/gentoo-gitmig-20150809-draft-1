# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-fastimport/bzr-fastimport-0.13.0.ebuild,v 1.2 2012/07/21 22:04:14 jdhore Exp $

EAPI="4"

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Plugin providing fast loading of revision control data into Bazaar"
HOMEPAGE="https://launchpad.net/bzr-fastimport http://wiki.bazaar.canonical.com/BzrFastImport"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-vcs/bzr-1.18
	>=dev-python/python-fastimport-0.9"
DEPEND=""

PYTHON_MODNAME="bzrlib/plugins/fastimport"

pkg_setup() {
	DOCS="NEWS README.txt doc/notes.txt"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	distutils_src_prepare
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "These commands need additional dependencies:"
	elog
	elog "bzr fast-export-from-darcs:  dev-vcs/darcs"
	elog "bzr fast-export-from-git:    dev-vcs/git"
	elog "bzr fast-export-from-hg:     dev-vcs/mercurial"
	elog "bzr fast-export-from-mtn:    dev-vcs/monotone"
	elog "bzr fast-export-from-svn:    dev-vcs/subversion[python]"
}
