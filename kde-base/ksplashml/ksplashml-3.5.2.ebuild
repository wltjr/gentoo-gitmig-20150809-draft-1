# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksplashml/ksplashml-3.5.2.ebuild,v 1.3 2006/04/01 19:03:53 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="xinerama"

RDEPEND="xinerama? ( || ( x11-libs/libXinerama virtual/x11 ) )"

DEPEND="${RDEPEND}
	xinerama? ( || ( x11-proto/xineramaproto virtual/x11 ) )"

src_compile() {
	myconf="${myconf} $(use_with xinerama)"

	kde-meta_src_compile
}
