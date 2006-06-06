# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyflakes/pyflakes-0.2.1.ebuild,v 1.3 2006/06/06 22:28:46 carlo Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Passive checker for python programs."
HOMEPAGE="http://divmod.org/projects/pyflakes"
SRC_URI="http://divmod.org/static/projects/pyflakes/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""