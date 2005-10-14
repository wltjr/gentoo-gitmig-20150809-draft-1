# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:41:54 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE file find utility"
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkonq)"


KMCOPYLIB="libkonq libkonq"
