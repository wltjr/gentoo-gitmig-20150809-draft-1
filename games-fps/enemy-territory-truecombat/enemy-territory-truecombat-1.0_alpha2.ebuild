# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-truecombat/enemy-territory-truecombat-1.0_alpha2.ebuild,v 1.2 2005/01/03 02:30:54 plasmaroo Exp $

MOD_DESC="True Combat"
MOD_NAME=tcetest
inherit games games-etmod

HOMEPAGE="http://truecombat.com/"
SRC_URI="http://tce.foghosting.com/releases/tcetest.zip
	http://www.lsfonline.com/tce/tcetest_update.zip"

LICENSE="GPL-2"

src_unpack () {
	unpack ${A}
	mv tcetest_update/* tcetest
}
