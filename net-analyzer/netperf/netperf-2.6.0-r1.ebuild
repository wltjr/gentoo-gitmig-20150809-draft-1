# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.6.0-r1.ebuild,v 1.2 2012/09/27 15:52:23 jer Exp $

EAPI=4
inherit eutils flag-o-matic

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
SRC_URI="ftp://ftp.netperf.org/${PN}/${P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
IUSE="demo sctp"

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_prepare() {
	sed -i src/netserver.c \
		-e '/^#define DEBUG_LOG_FILE_DIR/s:"/tmp/":"/var/log/":' \
		-e 's:sizeof(netperf_response) - 7:MAXSPECDATA:g' \
		|| die

	epatch "${FILESDIR}"/${PN}-fix-scripts.patch

	# Fixing paths in scripts
	sed -i -e 's:^\(NETHOME=\).*:\1"/usr/bin":' \
			doc/examples/sctp_stream_script \
			doc/examples/tcp_range_script \
			doc/examples/tcp_rr_script \
			doc/examples/tcp_stream_script \
			doc/examples/udp_rr_script \
			doc/examples/udp_stream_script

	# netlib.c:2292:5: warning: implicit declaration of function ‘sched_setaffinity’
	# nettest_omni.c:2943:5: warning: implicit declaration of function ‘splice’
	append-cppflags -D_GNU_SOURCE
}

src_configure() {
	econf \
		$(use_enable demo) \
		$(use_enable sctp)
}

src_install () {
	default

	# move netserver into sbin as we had it before 2.4 was released with its
	# autoconf goodness
	dodir /usr/sbin
	mv "${D}"/usr/{bin,sbin}/netserver || die

	# init.d / conf.d
	newinitd "${FILESDIR}"/${PN}-2.2-init netperf
	newconfd "${FILESDIR}"/${PN}-2.2-conf netperf

	# documentation and example scripts
	dodoc AUTHORS ChangeLog NEWS README Release_Notes
	dodir /usr/share/doc/${PF}/examples
	#Scripts no longer get installed by einstall
	cp doc/examples/*_script "${D}"/usr/share/doc/${PF}/examples
}
