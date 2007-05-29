# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/c-support/c-support-1.22.ebuild,v 1.2 2007/05/29 18:12:55 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Basic single-file add-ons for editing C code."
PKG_CAT="standard"

RDEPEND="app-xemacs/cc-mode
app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages
