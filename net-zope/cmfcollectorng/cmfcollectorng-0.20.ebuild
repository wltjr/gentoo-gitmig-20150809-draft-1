# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfcollectorng/cmfcollectorng-0.20.ebuild,v 1.3 2003/04/06 09:21:24 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope/CMF-based bugtracking system."
HOMEPAGE="http://www.zope.org/Members/ajung/CMFCollectorNG/Wiki/FrontPage"
SRC_URI="mirror://sourceforge/cmfcollectorng/CMFCollectorNG-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=net-zope/cmf-1.3
	${RDEPEND}"

ZPROD_LIST="CMFCollectorNG"

pkg_postinst()
{
	zproduct_pkg_postinst
	ewarn "Please use CMFQuickInstallerTool or read the documentation of this"
	ewarn "product for instruction on how to add this product to your CMF/Plone site."
}

