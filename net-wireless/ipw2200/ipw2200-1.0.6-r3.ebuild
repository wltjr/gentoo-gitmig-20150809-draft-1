# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200/ipw2200-1.0.6-r3.ebuild,v 1.2 2005/09/08 12:56:59 brix Exp $

inherit eutils linux-mod

# The following works with both pre-releases and releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

IEEE80211_VERSION="1.0.3-r2"
FW_VERSION="2.3"

DESCRIPTION="Driver for the Intel PRO/Wireless 2200BG/2915ABG miniPCI and 2225BG PCI adapters"
HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"
DEPEND=">=net-wireless/ieee80211-${IEEE80211_VERSION}"
RDEPEND="${DEPEND}
		=net-wireless/ipw2200-firmware-${FW_VERSION}
		net-wireless/wireless-tools"

BUILD_TARGETS="all"
MODULE_NAMES="ipw2200(net/wireless:)"
MODULESD_IPW2200_DOCS="README.ipw2200"

CONFIG_CHECK="NET_RADIO FW_LOADER"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if [[ ! -f /lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} ]]; then
		eerror
		eerror "Looks like you forgot to remerge net-wireless/ieee80211 after"
		eerror "upgrading your kernel."
		eerror
		eerror "Hint: use sys-kernel/module-rebuild for keeping track of which"
		eerror "modules needs to be remerged after a kernel upgrade."
		eerror
		die "/lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} not found"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} IEEE80211_INC=/usr/include"
}

src_unpack() {
	local debug="n"

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-a_txpow.patch
	epatch ${FILESDIR}/${P}-channel_change_fw_err.patch
	epatch ${FILESDIR}/${P}-dup-without-retry.patch
	epatch ${FILESDIR}/${P}-hwcrypt-wpa-fix4.patch
	epatch ${FILESDIR}/${P}-ibss-wep.patch
	epatch ${FILESDIR}/${P}-init_scan.patch
	epatch ${FILESDIR}/${P}-irq_override.patch
	epatch ${FILESDIR}/${P}-monitor_wep_fix.patch
	epatch ${FILESDIR}/${P}-open_frag.patch
	epatch ${FILESDIR}/${P}-pci_link-fix.patch
	epatch ${FILESDIR}/${P}-reset-mode-fix.patch

	epatch ${FILESDIR}/${P}-broadcast.patch
	kernel_is gt 2 6 12 && epatch ${FILESDIR}/${P}-suspend2.patch

	use debug && debug="y"
	sed -i -e "s:^\(CONFIG_IPW_DEBUG\)=.*:\1=${debug}:" ${S}/Makefile
}

src_compile() {
	linux-mod_src_compile

	einfo
	einfo "You may safely ignore any errors from above compilation that contain"
	einfo "warnings about undefined references to the ieee80211 subsystem."
	einfo
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES ISSUES
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [ -f /lib/modules/${KV_FULL}/net/${PN}.ko ]; then
		einfo
		einfo "Modules from an earlier installation detected. You will need to manually"
		einfo "remove those modules by running the following commands:"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/${PN}.ko"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/ieee80211*.ko"
		einfo "  # depmod -a"
		einfo
	fi
}
