# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/squirrelmail/squirrelmail-1.4.2.ebuild,v 1.1 2003/10/01 20:46:20 mholzer Exp $

DESCRIPTION="Webmail for nuts!"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.squirrelmail.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND="virtual/php
	dev-perl/DB_File"
DEPEND="${RDEPEND}"

HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"

pkg_setup() {
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old SquirrelMail version first."
		ewarn "SquirrelMail will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}

src_compile() {
	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	dodir ${HTTPD_ROOT}/${PN}
	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} ${PN}/data
}

pkg_postinst() {
	einfo "Squirrelmail NO LONGER requires PHP to have"
	einfo "'register_globals = On' !!!"
	old_ver=`ls ${HTTPD_ROOT}/${PN}-[0-9]* 2>/dev/null`
	if [ ! -z "${old_ver}" ]; then
		einfo ""
		einfo "You will also want to move old SquirrelMail data to"
		einfo "the new location:"
		einfo ""
		einfo "\tmv ${HTTPD_ROOT}/${PN}-OLDVERSION/data/* \\"
		einfo "\t\t${HTTPD_ROOT}/${PN}/data"
		einfo "\tmv ${HTTPD_ROOT}/${PN}-OLDVERSION/config/config.php \\"
		einfo "\t\t${HTTPD_ROOT}/${PN}/config"
	fi
}
