# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libutempter/libutempter-1.1.5.ebuild,v 1.4 2007/06/24 22:20:30 vapier Exp $

inherit eutils flag-o-matic versionator toolchain-funcs

DESCRIPTION="Library that allows non-privileged apps to write utmp (login) info, which need root access"
HOMEPAGE="http://altlinux.org/index.php?module=sisyphus&package=libutempter"
SRC_URI="ftp://ftp.altlinux.org/pub/people/ldv/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="!virtual/utempter"
RDEPEND="!virtual/utempter"

PROVIDE="virtual/utempter"

pkg_setup() {
	enewgroup utmp 406
}

src_compile() {
	use elibc_FreeBSD && append-flags -lutil
	emake \
		CC="$(tc-getCC)" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		libdir=/usr/$(get_libdir) \
		libexecdir=/usr/$(get_libdir)/misc || die
}

src_install() {
	make \
		DESTDIR="${D}" \
		libdir=/usr/$(get_libdir) \
		libexecdir=/usr/$(get_libdir)/misc \
		includedir=/usr/include \
		install || die

	fowners root:utmp /usr/$(get_libdir)/misc/utempter/utempter
	fperms 2755 /usr/$(get_libdir)/misc/utempter/utempter
	dodir /usr/sbin
	dosym ../$(get_libdir)/misc/utempter/utempter /usr/sbin/utempter
	dodoc README
}


pkg_postinst() {
	if [ -f "${ROOT}/var/log/wtmp" ]
	then
		chown root:utmp "${ROOT}/var/log/wtmp"
		chmod 664 "${ROOT}/var/log/wtmp"
	fi

	if [ -f "${ROOT}/var/run/utmp" ]
	then
		chown root:utmp "${ROOT}/var/run/utmp"
		chmod 664 "${ROOT}/var/run/utmp"
	fi
}
