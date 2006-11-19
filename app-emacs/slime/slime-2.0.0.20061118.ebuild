# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/slime/slime-2.0.0.20061118.ebuild,v 1.1 2006/11/19 06:41:01 mkennedy Exp $

inherit elisp eutils

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
# use ${FILESDIR}/new-slime-ball to create new snapshots
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="virtual/emacs
	virtual/commonlisp
	doc? ( sys-apps/texinfo )"

CLPACKAGE=swank

src_compile() {
	elisp-comp *.el || die
	use doc && make -C doc slime.info
}

src_install() {
	elisp-install ${PN} *
	elisp-site-file-install ${FILESDIR}/70slime-gentoo.el
 	dodoc README* ChangeLog HACKING NEWS PROBLEMS
 	dodir /usr/share/common-lisp/systems
 	dosym /usr/share/emacs/site-lisp/${PN}/swank.asd \
 		/usr/share/common-lisp/systems/
	if use doc; then
		doinfo doc/slime.info
	fi
}
