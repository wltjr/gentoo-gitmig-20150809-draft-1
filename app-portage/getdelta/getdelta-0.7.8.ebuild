# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/getdelta/getdelta-0.7.8.ebuild,v 1.3 2010/03/31 13:12:08 idl0r Exp $

DESCRIPTION="dynamic deltup client"
HOMEPAGE="http://linux01.gwdg.de/~nlissne/"
SRC_URI="http://linux01.gwdg.de/~nlissne/${P}.tar.bz2"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

RDEPEND="app-portage/deltup
	dev-util/bdelta"

src_install () {
	sed -i -e "s:/bin/sh:/bin/bash:" "${WORKDIR}"/getdelta.sh || die
	dobin "${WORKDIR}"/getdelta.sh || die
}

pkg_postinst() {
	elog "You need to put"
	elog "FETCHCOMMAND=\"/usr/bin/getdelta.sh \\\${URI}\""
	elog "into your /etc/make.conf to make use of getdelta"

	# make sure permissions are ok
	touch "${ROOT}"/var/log/getdelta.log
	mkdir -p "${ROOT}"/etc/deltup
	chown -R portage:portage "${ROOT}"/{var/log/getdelta.log,etc/deltup}
	chmod -R ug+rwX "${ROOT}"/{var/log/getdelta.log,etc/deltup}
}
