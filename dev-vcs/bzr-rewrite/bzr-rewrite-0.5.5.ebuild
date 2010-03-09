# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-rewrite/bzr-rewrite-0.5.5.ebuild,v 1.1 2010/03/09 09:59:35 fauli Exp $

EAPI=2

inherit distutils eutils

DESCRIPTION="Bazaar plugin that adds support for rebasing, similar to the functionality in git"
HOMEPAGE="http://bazaar-vcs.org/Rebase"
SRC_URI="http://samba.org/~jelmer/bzr/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-vcs/bzr-1.14
	!dev-vcs/bzr-rebase"
RDEPEND="${DEPEND}
	!<dev-vcs/bzr-svn-0.6"
