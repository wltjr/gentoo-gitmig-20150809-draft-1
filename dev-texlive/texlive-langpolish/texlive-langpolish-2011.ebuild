# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langpolish/texlive-langpolish-2011.ebuild,v 1.5 2012/01/29 20:13:08 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="cc-pl gustlib gustprog mex mwcls pl polski qpxqtx tap utf8mex hyphen-polish collection-langpolish
"
TEXLIVE_MODULE_DOC_CONTENTS="cc-pl.doc gustlib.doc gustprog.doc mex.doc mwcls.doc pl.doc polski.doc qpxqtx.doc tap.doc utf8mex.doc "
TEXLIVE_MODULE_SRC_CONTENTS="mex.source mwcls.source polski.source tap.source "
inherit  texlive-module
DESCRIPTION="TeXLive Polish"

LICENSE="GPL-2 LPPL-1.2 LPPL-1.3 public-domain TeX "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2011
>=dev-texlive/texlive-basic-2011
"
RDEPEND="${DEPEND} "
