# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.8.0.ebuild,v 1.2 2007/03/12 20:28:01 opfer Exp $

inherit autotools flag-o-matic

DESCRIPTION="Handles power management and special keys on laptops."
HOMEPAGE="http://pbbuttons.berlios.de"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE="acpi alsa debug doc ibam macbook oss"

DEPEND="macbook? ( sys-libs/libsmbios )
		>=dev-libs/glib-2.6
		doc? ( app-doc/doxygen )"
RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0 )
		 >=dev-libs/glib-2.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	eautoconf
}

src_compile() {
	# Fix crash bug on some systems
	replace-flags -O? -O1

	if use macbook; then
		laptop=macbook
	elif use x86 || use amd64; then
		if use acpi; then
			laptop=acpi
		else
			laptop=i386
		fi
	# Default to PowerBook
	else
		laptop=powerbook
	fi

	econf laptop=$laptop \
		$(use_enable debug) \
		$(use_with doc doxygen_docs) \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with ibam) \
		|| die "Sorry, failed to configure pbbuttonsd"

	# Thanks to Stefan Bruda for this workaround
	# Using -j1 fixes a parallel build issue with the docs
	if use doc; then
		emake -j1 || die "Sorry, failed to compile pbbuttonsd"
	else
		emake || die "Sorry, failed to compile pbbuttonsd"
	fi
}

src_install() {
	dodir /etc/power
	use ibam && dodir /var/lib/ibam
	make DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d
	newexe ${FILESDIR}/pbbuttonsd.rc6 pbbuttonsd
	dodoc README
	use doc && dohtml -r doc/*
}

pkg_postinst() {
	if [ -e /etc/pbbuttonsd.conf ]; then
		ewarn "The pbbuttonsd.cnf file replaces /etc/pbuttonsd.conf with a new"
		ewarn "file (/etc/pbbuttonsd.conf) and a new format.  Please check the"
		ewarn "manual page with 'man pbbuttonsd.cnf' for details."
		ewarn
	fi

	if use macbook; then
		ewarn "Macbook and Macbook Pro users should make sure to have applesmc"
		ewarn "loaded before starting pbbuttonsdm otherwise auto-adjustments"
		ewarn "will not work and pbbuttonsd may segfault."
	fi

	ewarn "Ensure that the evdev kernel module is loaded otherwise"
	ewarn "pbbuttonsd won't work.  SysV IPC is also required."
	ewarn
	ewarn "If you need extra security, you can tell pbbuttonsd to only accept"
	ewarn "input from one user.  You can set the userallowed option in"
	ewarn "/etc/pbbuttonsd.conf to limit access."
	ewarn

	if use ibam; then
		elog "To properly initialize the IBaM battery database, you will"
		elog "need to perform a full discharge/charge cycle.  For more"
		elog "details, please see the pbbuttonsd man page."
		elog
	fi
}
