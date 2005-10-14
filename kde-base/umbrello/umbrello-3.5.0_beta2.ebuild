# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:42:02 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~amd64"
IUSE=""

# Fix compilation. Applied for rc1.
PATCHES="${FILESDIR}/kdesdk-3.5_beta1-compile.patch
	${FILESDIR}/kdesdk-3.5_beta1-crash.patch
	${FILESDIR}/umbrello-qt-3.3.5.patch"
