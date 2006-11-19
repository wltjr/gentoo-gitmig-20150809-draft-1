# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-1.0.0.ebuild,v 1.1 2006/11/19 21:25:08 rl03 Exp $

inherit webapp

MY_PV=${PV//./_}
DESCRIPTION="phpWebSite Content Management System"
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="http://phpwebsite.appstate.edu/downloads/stable/full/${PV}/${PN}_${MY_PV}.tgz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/httpd-php"

S="${WORKDIR}"/${PN}_${MY_PV}

src_install() {
	webapp_src_preinst

	dodoc README docs/*

	cp -r * "${D}/${MY_HTDOCSDIR}"

	# Files that need to be owned by webserver
	webapp_serverowned ${MY_HTDOCSDIR}/config
	webapp_serverowned ${MY_HTDOCSDIR}/config/core
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/images
	webapp_serverowned ${MY_HTDOCSDIR}/images/mod
	webapp_serverowned ${MY_HTDOCSDIR}/mod
	webapp_serverowned ${MY_HTDOCSDIR}/logs
	webapp_serverowned ${MY_HTDOCSDIR}/templates
	webapp_serverowned ${MY_HTDOCSDIR}/javascript/modules

#	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
