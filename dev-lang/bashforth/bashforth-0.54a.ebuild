# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/bashforth/bashforth-0.54a.ebuild,v 1.1 2006/02/17 21:19:50 mkennedy Exp $

DESCRIPTION="BashForth is a string-threaded Forth interpreter in Bash."
HOMEPAGE="http://www.forthfreak.net/index.cgi?BashForth"
SRC_URI="mirror://gentoo/bashforth_v${PV}.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">app-shells/bash-2.04"

S=${WORKDIR}

src_install() {
	newbin bashforth_v${PV} bashforth
}
