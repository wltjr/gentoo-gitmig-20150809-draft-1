# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/man2html/man2html-1.5l.ebuild,v 1.7 2004/07/13 22:20:58 agriffis Exp $

inherit eutils webapp-apache

DESCRIPTION="Convert manual pages to HTML"
HOMEPAGE="http://freshmeat.net/projects/man/"
SRC_URI="mirror://kernel/linux/utils/man/man-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha sparc x86"
IUSE=""

DEPEND="app-misc/glimpse
	sys-apps/gawk
	sys-apps/man"

S=${WORKDIR}/man-${PV}

pkg_setup() {
	webapp-detect || NO_HTTPD=1
	webapp-pkg_setup "${NO_HTTPD}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/mansearch-gentoo.patch
	epatch ${FILESDIR}/manwhatis-gentoo.patch
}

src_compile() {
	:
}

src_install() {
	webapp-mkdirs

	cd man2html
	exeinto ${HTTPD_CGIBIN}/man
	doexe scripts/cgi-bin/man/*
	insinto ${HTTPD_CGIBIN/bin/aux}/man
	doins scripts/cgi-aux/man/*
	insinto /var/man2html
	newins glimpse_filters .glimpse_filters
	fperms 1777 /var/man2html
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/man2html.cron
}

pkg_postinst() {
	einfo Run
	einfo "\tebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo to complete installation.
}

pkg_config() {
	einfo Running makewhatis
	/usr/sbin/makewhatis
	eend $?
	einfo Running glimpseindex
	/usr/bin/glimpseindex -z -H /var/man2html `man -w | tr : ' '`
	eend $?
	chmod 644 /var/man2html/.glimpse*
	einfo Manual pages are available at http://localhost/cgi-bin/man/man2html
}
