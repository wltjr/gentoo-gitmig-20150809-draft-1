# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pam/kdebase-pam-6.ebuild,v 1.9 2006/04/01 17:27:06 flameeyes Exp $

inherit pam

DESCRIPTION="pam.d files used by several KDE components."
HOMEPAGE="http://www.kde.org"
LICENSE="as-is"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/pam"

src_install() {
	newpamd "${FILESDIR}/kde.pam-${PV}" kde
	newpamd "${FILESDIR}/kde-np.pam-${PV}" kde-np
}
