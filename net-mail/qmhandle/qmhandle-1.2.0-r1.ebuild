# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmhandle/qmhandle-1.2.0-r1.ebuild,v 1.3 2005/09/24 04:21:28 vapier Exp $

inherit eutils

DESCRIPTION="Qmail message queue tool"
HOMEPAGE="http://qmhandle.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmhandle/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ppc sparc x86"
IUSE=""
RESTRICT="compile"

RDEPEND="|| ( mail-mta/qmail mail-mta/qmail-mysql mail-mta/qmail-ldap )
	dev-lang/perl
	sys-process/psmisc"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/qmHandle-gentoo-svc.patch
}

src_install() {
	dodoc README HISTORY
	dobin qmHandle || die "dobin failed"
}
