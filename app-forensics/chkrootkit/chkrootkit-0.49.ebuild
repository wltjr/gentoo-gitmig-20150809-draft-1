# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/chkrootkit/chkrootkit-0.49.ebuild,v 1.5 2011/09/22 20:26:47 radhermit Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Tool to locally check for signs of a rootkit"
HOMEPAGE="http://www.chkrootkit.org/"
SRC_URI="
	ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="virtual/cron"

src_prepare() {
	epatch "${WORKDIR}/${P}-gentoo.diff"
	sed -i 's:/var/adm/:/var/log/:g' chklastlog.c || die "sed chklastlog.c failed"
}

src_compile() {
	emake CC=$(tc-getCC) STRIP=true sense
}

src_install() {
	dosbin chkdirs chklastlog chkproc chkrootkit chkwtmp chkutmp ifpromisc strings-static
	dodoc ACKNOWLEDGMENTS README*

	exeinto /etc/cron.weekly
	newexe "${FILESDIR}"/${PN}.cron ${PN}
}

pkg_postinst() {
	elog
	elog "Edit /etc/cron.weekly/chkrootkit to activate chkrootkit!"
	elog
	elog "Some applications, such as portsentry, will cause chkrootkit"
	elog "to produce false positives.  Read the chkrootkit FAQ at"
	elog "http://www.chkrootkit.org/ for more information."
	elog
}
