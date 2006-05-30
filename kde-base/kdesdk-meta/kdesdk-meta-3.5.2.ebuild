# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-meta/kdesdk-meta-3.5.2.ebuild,v 1.6 2006/05/30 05:09:40 josejx Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdesdk - merge this to pull in all kdesdk-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE="subversion"

RDEPEND="
	$(deprange $PV $MAXKDEVER kde-base/cervisia)
	$(deprange 3.5.0 $MAXKDEVER kde-base/kapptemplate)
	$(deprange $PV $MAXKDEVER kde-base/kbabel)
	$(deprange $PV $MAXKDEVER kde-base/kbugbuster)
	$(deprange $PV $MAXKDEVER kde-base/kcachegrind)
	$(deprange 3.5.1 $MAXKDEVER kde-base/kdesdk-kfile-plugins)
	$(deprange 3.5.0 $MAXKDEVER kde-base/kdesdk-misc)
	$(deprange $PV $MAXKDEVER kde-base/kdesdk-scripts)
	$(deprange $PV $MAXKDEVER kde-base/kmtrace)
	$(deprange 3.5.1 $MAXKDEVER kde-base/kompare)
	$(deprange 3.5.0 $MAXKDEVER kde-base/kspy)
	$(deprange 3.5.1 $MAXKDEVER kde-base/kuiviewer)
	subversion? ( $(deprange $PV $MAXKDEVER kde-base/kdesdk-kioslaves) )
	$(deprange 3.5.1 $MAXKDEVER kde-base/umbrello)"
