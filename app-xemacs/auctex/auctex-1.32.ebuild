# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/auctex/auctex-1.32.ebuild,v 1.5 2004/03/13 00:15:35 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Basic TeX/LaTeX support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages
