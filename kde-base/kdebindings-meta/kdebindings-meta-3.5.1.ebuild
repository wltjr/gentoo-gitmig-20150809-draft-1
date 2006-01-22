# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.5.1.ebuild,v 1.1 2006/01/22 22:52:55 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# Unslotted packages aren't depended on via deprange
RDEPEND="
>=kde-base/dcopperl-3.5.0_beta2
>=kde-base/dcoppython-3.5.0_beta2
$(deprange $PV $MAXKDEVER kde-base/kalyptus)
$(deprange 3.5.0 $MAXKDEVER kde-base/kdejava)
$(deprange $PV $MAXKDEVER kde-base/kjsembed)
>=kde-base/korundum-$PV
$(deprange 3.5.0 $MAXKDEVER kde-base/qtjava)
>=kde-base/qtruby-$PV
$(deprange 3.5.0 $MAXKDEVER kde-base/smoke)"


# Omitted: qtsharp, dcopc, dcopjava, xparts (considered broken by upstream) 
