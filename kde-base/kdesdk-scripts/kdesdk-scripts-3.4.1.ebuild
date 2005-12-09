# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-3.4.1.ebuild,v 1.8 2005/12/09 10:06:26 josejx Exp $

KMNAME=kdesdk
KMMODULE="scripts"
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kdesdk Scripts - Some useful scripts for the development of applications"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""