# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.5.1.ebuild,v 1.4 2002/10/18 20:34:09 vapier Exp $
inherit kde-base

DESCRIPTION="An imagemap editor for KDE"
SRC_URI="mirror://sourceforge/kimagemapeditor/${P}-kde3.tar.gz"
HOMEPAGE="http://kimagemapeditor.sourceforge.net/"

need-kde 3

LICENSE="GPL-2"
KEYWORDS="x86"

[ "$COMPILER" == "gcc3" ] && PATCHES="$FILESDIR/$P-gcc3.diff"
