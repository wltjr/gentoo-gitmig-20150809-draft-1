# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr/vdr-1.4.1-r2.ebuild,v 1.1 2006/06/27 18:30:16 zzam Exp $

inherit eutils flag-o-matic multilib

IUSE="debug vanilla aio bigpatch jumpplay dolby-record-switch dvbplayer
	lnbsharing sourcecaps cmdsubmenu dxr3-audio-denoise
	child-protection yaepg setup-plugin submenu subtitles rotor"

PATCHSET_V=2
PATCHSET_NAME=gentoo-${PN}-patchset-${PV}-${PATCHSET_V}

DESCRIPTION="Video Disk Recorder - turns a pc into a powerful set top box for DVB"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/${P}.tar.bz2
	!vanilla? ( mirror://gentoo/${PATCHSET_NAME}.tar.bz2
				http://dev.gentoo.org/~zzam/distfiles/${PATCHSET_NAME}.tar.bz2 )"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"


DEPEND="media-libs/jpeg
	sys-apps/gawk
	media-tv/linuxtv-dvb-headers
	sys-libs/libcap"

RDEPEND="${DEPEND}
	dev-lang/perl
	media-tv/vdrplugin-rebuild
	!vanilla? ( >=media-tv/gentoo-vdr-scripts-0.3.5 )"

# Relevant Pathes for vdr on gentoo
DVB_DIR=/usr/include
VDR_INCLUDE_DIR=/usr/include/vdr
PLUGIN_LIB_DIR=/usr/$(get_libdir)/vdr/plugins
CONF_DIR=/etc/vdr
CAP_FILE=${S}/capabilities.sh
CAPS="# Capabilities of the vdr-executable for use by startscript etc."


pkg_setup() {
	use debug && append-flags -g
}

add_cap() {
	while [ "$1" ]; do
		CAPS="${CAPS}\n$1=1"
		shift
	done
}

# works like use to check for active (and not active !abc) useflags
# if more than one flag is given it returns that all flags are active
#
# "use_multi_and a b !c !d"
# ==
# "use a && use b && use !c && use !d"
#
use_multi_and() {
	while [[ -n ${1} ]]; do
		use ${1} || return 1

		shift
	done
	return 0
}

# reads the line GENTOO_USE out of the beginning of the patch
# example: GENTOO_USE: aio !bigpatch
# and checks weather the useflags are set appropriate (via use_multi_and)
# if check returns true the patch is applied
#
apply_vdr_patch() {
	local APPLY=0
	local COUNT_USE=0
	local CAP=""
	local p="${1}"
	debug-print "PATCH:"
	debug-print "  $(basename ${p})"
	local V1
	local V2
	while read V1 V2; do
		case ${V1} in
		GENTOO_USE:)
			: $((COUNT_USE++))
			if use_multi_and ${V2}; then
				APPLY=1
			fi
			;;
		GENTOO_CAP:)
			CAP="${V2}"
			;;
		+++|---|diff|@@)
			break;
			;;
		*)
			;;
		esac
	done < "${p}"
	if [[ ${COUNT_USE} -eq 0 ]]; then
		APPLY=1
	fi
	[[ ${APPLY} == 0 ]] && return
	debug-print "    --> applied"
	epatch "${p}"
	[[ -n "${CAP}" ]] && add_cap ${CAP}
}

# call apply_vdr_patch for all patchfiles in given directory

apply_vdr_patchset() {
	local p
	for p in ${1}/*.{diff,patch}; do
		[[ -f "${p}" ]] || continue
		apply_vdr_patch "${p}"
	done
}

src_unpack() {
	unpack ${P}.tar.bz2
	if [[ -n "${VDR_LOCAL_PATCHSET}" && -d "${ROOT}/${VDR_LOCAL_PATCHSET}" ]]; then
		ewarn "Using local developer patchset."
		PATCHSET_DIR="${ROOT}/${VDR_LOCAL_PATCHSET}"
	else
		unpack ${PATCHSET_NAME}.tar.bz2
		PATCHSET_DIR=${WORKDIR}/${PATCHSET_NAME}
	fi

	cd ${S}

	ebegin "Changing pathes for gentoo"
	sed -e 's-$(DVBDIR)/include-$(DVBDIR)-' -i Makefile

	sed \
	  -e 's-ConfigDirectory = VideoDirectory;-ConfigDirectory = CONFIGDIR;-' \
	  -i vdr.c

	cat > Make.config <<-EOT
		#
		# Generated by ebuild ${PF}
		#
		DVBDIR		 = ${DVB_DIR}
		PLUGINLIBDIR = ${PLUGIN_LIB_DIR}
		CONFIGDIR	 = ${CONF_DIR}

		DEFINES		+= -DCONFIGDIR=\"\$(CONFIGDIR)\"
	EOT
	eend 0

	if use vanilla; then
		ewarn "OK - You are on your own now!"
		ewarn "no gentoo-patches will be applied!"
	else
		apply_vdr_patchset ${PATCHSET_DIR}

		if use setup-plugin && use submenu; then
			ewarn "Did not apply submenu-patch, can not be used at the same time as setup-plugin-patch."
		fi
	fi

	# apply local patches defined by variable VDR_LOCAL_PATCHES_DIR
	if test -n "${VDR_LOCAL_PATCHES_DIR}"; then
		echo
		einfo "Applying local patches"
		for LOCALPATCH in ${VDR_LOCAL_PATCHES_DIR}/${PV}/*.{diff,patch}; do
			test -f "${LOCALPATCH}" && epatch "${LOCALPATCH}"
		done
	fi

	if [[ -n "${VDRSOURCE_DIR}" ]]; then
		cp -r ${S} ${T}/source-tree
	fi


	if ! use vanilla; then
		add_cap CAP_IRCTRL_RUNTIME_PARAM \
			CAP_VFAT_RUNTIME_PARAM \
			CAP_SHUTDOWN_SVDRP \
			CAP_CHUID

		echo -e ${CAPS} > ${CAP_FILE}
	fi
}

src_install() {
	exeinto /usr/bin
	doexe vdr
	doexe svdrpsend.pl

	insinto ${VDR_INCLUDE_DIR}
	doins *.h
	doins Make.config

	insinto ${VDR_INCLUDE_DIR}/libsi
	doins libsi/*.h

	keepdir ${CONF_DIR}/plugins
	keepdir ${CONF_DIR}/themes

	insinto ${CONF_DIR}
	doins *.conf channels.conf.*

	keepdir "${PLUGIN_LIB_DIR}"

	doman vdr.1 vdr.5

	dohtml *.html
	dodoc MANUAL INSTALL README* HISTORY*
	dodoc TODO-enAIO-rm CONTRIBUTORS

	insinto /usr/share/vdr
	doins ${CAP_FILE}

	if [[ -n "${VDRSOURCE_DIR}" ]]; then
		einfo "Installing sources"
		insinto ${VDRSOURCE_DIR}/${P}
		doins -r ${T}/source-tree/*
		keepdir ${VDRSOURCE_DIR}/${P}/PLUGINS/lib
	fi

	if use setup-plugin; then
		insinto /usr/share/vdr/setup
		doins ${S}/menu.c

		insinto /etc/vdr/plugins/setup
		newins ${FILESDIR}/vdr-setup-menu-0.2.3.xml vdr-menu.xml
	fi
	chown -R vdr:vdr ${D}/${CONF_DIR}
}

pkg_postinst() {
	einfo "It is a good idea to run vdrplugin-rebuild now"
	if has_version "<media-video/vdr-1.3.36-r3"; then
		ewarn "Upgrade Info:"
		ewarn
		ewarn "If you had used the use-flags lirc, rcu or vfat"
		ewarn "then, you now have to enable the associated functionality"
		ewarn "in /etc/conf.d/vdr"
		ewarn
		ewarn "vfat is now set with VFAT_FILENAMES."
		ewarn "lirc/rcu are now set with IR_CTRL."
		ebeep
	fi

	if use setup-plugin; then
		echo
		eerror "It is very important to emerge media-plugins/vdr-setup now"
		eerror "and to have it activated in /etc/conf.de/vdr PLUGINS=\"\""
	fi

	local keysfound=0
	local key
	local warn_keys="JumpFwd JumpRew JumpFwdSlow JumpRewSlow"
	local remote_file=${ROOT}/etc/vdr/remote.conf

	if [[ -e ${remote_file} ]]; then
		for key in ${warn_jeys}; do
			if grep -q -i "\.${key} " "${remote_file}"; then
				keysfound=1
				break
			fi
		done
		if [[ ${keysfound} == 1 ]]; then
			ewarn "Your /etc/vdr/remote.conf contains keys which are no longer usable"
			ewarn "Please remove these keys or vdr will not start:"
			ewarn "#  ${warn_keys}"
		fi
	fi
}
