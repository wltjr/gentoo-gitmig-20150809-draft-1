# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sandbox/sandbox-1.2.1-r3.ebuild,v 1.2 2005/04/24 18:24:31 eradicator Exp $

inherit eutils flag-o-matic eutils toolchain-funcs multilib
#
# don't monkey with this ebuild unless contacting portage devs.
# period.
#

IUSE=""
DESCRIPTION="sandbox'd LD_PRELOAD hack"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~azarah/sandbox/${P}.tar.bz2"
DEPEND=""
LICENSE="GPL-2"
SLOT='0'

#KEYWORDS="  alpha  amd64  arm  hppa  ia64  mips  ppc  ppc-macos  ppc64  s390  sh  sparc  x86"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"

# This revbump just fixes multilib on amd64's 2005.0
KEYWORDS="~amd64"

RESTRICT="multilib-pkg-force"

check_multilib() {
	has_m32
	if [ "$?" == 0 ]; then
		einfo "Found valid multilib environment."
		einfo "Building with multilib support."
		export MULTILIB="1"
	else
		ewarn "No valid multilib environment found!"
		ewarn "Building without multilib support. If"
		ewarn "you want to have multilib support,"
		ewarn "emerge gcc with \"multilib\" in your"
		ewarn "useflags."
	fi
}

src_unpack() {
	if has_multilib_profile; then
		for TA in $(get_install_abis); do
			unpack ${A} || die "unpack failed"
			cd ${S}
			epunt_cxx
			cd ${WORKDIR}
			mv ${S} ${S%/}-${TA} || die "failed mving \$S to $TA"
		done
	else
		unpack ${A} || die "unpack failed"
		cd ${S}
		epunt_cxx
	fi
}

src_compile() {
	if has_multilib_profile; then
		OABI="${ABI}"
		export CFLAGS="${CFLAGS} -DSB_HAVE_64BIT_ARCH"
		for ABI in $(get_install_abis); do
			export ABI
			cd ${S}-${ABI}
			econf --libdir="/usr/$(get_libdir)" || die "econf failed for $ABI"
			emake || die "emake failed for $ABI"
		done
		ABI="${OABI}"
	else
		if useq amd64; then
			check_multilib
			export HAVE_64BIT_ARCH="${MULTILIB}"
		fi
		cd ${S}
		econf || die "econf failed"
		emake || die "emake failed"
	fi
}

src_install() {
	if has_multilib_profile; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			export ABI
			cd ${S}-${ABI}
			make DESTDIR="${D}" install || die "make install failed for $ABI"
		done
		ABI="${OABI}"
	else
		cd ${S}
		einstall || die "einstalled failed"
	fi
}
