# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/c-support/c-support-1.16.ebuild,v 1.6 2004/03/13 00:15:35 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Basic single-file add-ons for editing C code."
PKG_CAT="standard"

DEPEND="app-xemacs/cc-mode
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages
