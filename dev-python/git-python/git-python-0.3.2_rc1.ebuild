# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/git-python/git-python-0.3.2_rc1.ebuild,v 1.1 2011/08/27 14:24:18 zorry Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="GitPython"
MY_PV=${PV/_rc/.RC}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="GitPython is a python library used to interact with Git repositories."
HOMEPAGE="http://gitorious.org/git-python http://pypi.python.org/pypi/GitPython"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-vcs/git"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="git"
