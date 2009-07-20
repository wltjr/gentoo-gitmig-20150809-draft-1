# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-9.0.4.ebuild,v 1.1 2009/07/20 04:08:40 jer Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.orange.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	sa_lib_dir=/usr/$(get_libdir)/sa \
		econf $(use_enable nls) conf_dir=/etc || die "econf failed"
}

src_compile() {
	emake LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	keepdir /var/log/sa

	emake DESTDIR="${D}" DOC_DIR=/usr/share/doc/${PF} \
		install || die "make install failed"

	newdoc sysstat.crond.sample crontab.example
	newinitd "${FILESDIR}"/sysstat.init.d sysstat

	ewarn "The sysstat configuration files have moved from /etc/sysconfig to /etc"
}
