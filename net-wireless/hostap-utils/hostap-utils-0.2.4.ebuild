# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap-utils/hostap-utils-0.2.4.ebuild,v 1.2 2004/10/26 10:36:59 brix Exp $

inherit eutils

DESCRIPTION="HostAP wireless utils"
HOMEPAGE="http://hostap.epitest.fi/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=net-wireless/hostap-driver-0.2.4"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	for i in \
		hostap_crypt_conf hostap_diag hostap_io_debug hostap_rid \
		prism2_param prism2_srec hostap_fw_load \
		split_combined_hex; do
		dosbin "${i}"
	done
	dodoc README
}
