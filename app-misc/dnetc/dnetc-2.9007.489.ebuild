# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dnetc/dnetc-2.9007.489.ebuild,v 1.5 2004/07/11 02:19:06 agriffis Exp $

MAJ_PV=${PV:0:6}
MIN_PV=${PV:7:9}

DESCRIPTION="distributed.net client"
HOMEPAGE="http://www.distributed.net"
SRC_URI=" x86? ( http://http.distributed.net/pub/dcti/v${MAJ_PV}/dnetc${MIN_PV}-linux-x86-elf-uclibc.tar.gz )"
LICENSE="distributed.net"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha -mips -hppa"
IUSE=""
DEPEND=""
RDEPEND="net-dns/bind-tools"
S="${WORKDIR}/dnetc${MIN_PV}-linux-x86-elf-uclibc"

RESTRICT="nomirror"

pkg_preinst() {
	if [ -e /opt/distributed.net/dnetc ] && [ -e /etc/init.d/dnetc ]; then
		einfo "flushing old buffers"
		/opt/distributed.net/dnetc -quiet -flush
		einfo "removing old buffer files"
		rm -f /opt/distributed.net/buff*
	fi
}

src_install() {
	exeinto /opt/distributed.net
	doexe dnetc

	doman dnetc.1
	dodoc CHANGES.txt dnetc.txt readme.*

	exeinto /etc/init.d ; newexe ${FILESDIR}/dnetc.init dnetc
	insinto /etc/conf.d ; newins ${FILESDIR}/dnetc.conf dnetc
}

pkg_postinst() {
	einfo "Either configure your email address in /etc/conf.d/dnetc"
	einfo "or create the configuration file /opt/distributed.net/dnetc.ini"
}

pkg_postrm() {
	if [ -d /opt/distributed.net ]; then
		einfo "All files has not been removed from /opt/distributed.net"
	fi
}
