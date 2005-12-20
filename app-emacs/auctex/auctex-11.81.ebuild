# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-11.81.ebuild,v 1.1 2005/12/20 08:50:13 usata Exp $

inherit elisp eutils

DESCRIPTION="AUCTeX is an extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="preview-latex"

DEPEND="virtual/tetex
	preview-latex? ( !dev-tex/preview-latex )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# skip XEmacs detection. this is a workaround for emacs23
	epatch ${FILESDIR}/${P}-configure.diff
}

src_compile() {
	econf --disable-build-dir-test \
		--with-auto-dir=${D}/var/lib/auctex \
		--with-lispdir=${D}/usr/share/emacs/site-lisp \
		$(use_enable preview-latex preview) || die "econf failed"
	emake || die

	# bug #72637
	elisp-comp *.el || die
}

src_install() {
	einstall || die
	elisp-install ${PN} bib-cite.el* tex-jp.el* || die
	dosed ${SITELISP}/tex-site.el || die
	elisp-site-file-install ${FILESDIR}/50auctex-gentoo.el
	dodoc ChangeLog CHANGES README RELEASE TODO FAQ INSTALL*
}
