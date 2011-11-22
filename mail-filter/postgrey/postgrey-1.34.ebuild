# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/postgrey/postgrey-1.34.ebuild,v 1.2 2011/11/22 16:10:16 phajdan.jr Exp $

EAPI=4

inherit eutils

DESCRIPTION="Postgrey is a Postfix policy server implementing greylisting"
HOMEPAGE="http://postgrey.schweikert.ch/"
SRC_URI="http://postgrey.schweikert.ch/pub/${P}.tar.gz
	http://postgrey.schweikert.ch/pub/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.0
	dev-perl/net-server
	dev-perl/IO-Multiplex
	dev-perl/BerkeleyDB
	dev-perl/Net-DNS
	dev-perl/Parse-Syslog
	dev-perl/Net-RBLClient
	>=sys-libs/db-4.1"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	# postgrey data/DB in /var
	diropts -m0770 -o ${PN} -g ${PN}
	dodir /var/spool/postfix/${PN}
	keepdir /var/spool/postfix/${PN}
	fowners postgrey:postgrey /var/spool/postfix/${PN}
	fperms 0770 /var/spool/postfix/${PN}

	# postgrey binary
	dosbin ${PN}
	dosbin contrib/postgreyreport

	# policy-test script
	dosbin policy-test

	# postgrey data in /etc/postfix
	insinto /etc/postfix
	insopts -o root -g ${PN} -m 0640
	doins postgrey_whitelist_clients postgrey_whitelist_recipients

	# documentation
	dodoc Changes README

	# init.d + conf.d files
	insopts -o root -g root -m 755
	newinitd "${FILESDIR}"/${PN}.rc.new ${PN}
	insopts -o root -g root -m 640
	newconfd "${FILESDIR}"/${PN}.conf.new ${PN}
}
