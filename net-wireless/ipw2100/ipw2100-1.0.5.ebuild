# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2100/ipw2100-1.0.5.ebuild,v 1.2 2005/03/02 20:51:14 brix Exp $

inherit linux-mod eutils

FW_VERSION="1.3"

DESCRIPTION="Driver for the Intel PRO/Wireless 2100 3B miniPCI adapter"

HOMEPAGE="http://ipw2100.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="debug"
RDEPEND="=net-wireless/ipw2100-firmware-${FW_VERSION}
		>=net-wireless/wireless-tools-27_pre23
		!net-wireless/ipw2200"

BUILD_PARAMS="KSRC=${KV_DIR}"
BUILD_TARGETS="all"

MODULE_NAMES="ipw2100(net:)
			ieee80211(net:)
			ieee80211_crypt(net:)
			ieee80211_crypt_wep(net:)
			ieee80211_crypt_ccmp(net:)
			ieee80211_crypt_tkip(net:)"
MODULESD_IPW2100_DOCS="README.ipw2100"

CONFIG_CHECK="NET_RADIO CRYPTO_ARC4 CRYPTO_MICHAEL_MIC FW_LOADER CRC32"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
CRYPTO_ARC4_ERROR="${P} requires support for ARC4 cipher algorithm (CONFIG_CRYPTO_ARC4)."
CRYPTO_MICHAEL_MIC_ERROR="${P} requires support for Michael MIC keyed digest algorithm (CONFIG_CRYPTO_MICHAEL_MIC)."
FW_LOADER_ERROR="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
CRC32_ERROR="${P} requires support for CRC32 functions (CONFIG_CRC32)."

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if linux_chkconfig_present CRYPTO_AES_586 && linux_chkconfig_present CRYPTO_AES; then
		eerror "${P} requires support for AES cipher algorithms (i586) (CONFIG_CRYPTO_AES_586)."
		eerror "This option is called CONFIG_CRYPTO_AES in kernels prior to 2.6.8."
		die "CONFIG_CRYPTO_AES_586 support not detected"
	fi

	linux-mod_pkg_setup
}

src_unpack() {
	local debug="n"

	unpack ${A}

	use debug && debug="y"
	sed -i \
		-e "s:^\(CONFIG_IPW_DEBUG\)=.*:\1=$debug:" \
		-e "s:^\(CONFIG_IEEE80211_DEBUG\)=.*:\1=$debug:" \
		${S}/Makefile

	einfo "Patching Makefile to enable WPA"
	sed -i "s:^# CONFIG_IEEE80211_WPA=:CONFIG_IEEE80211_WPA=:" \
		${S}/Makefile

	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES
}
