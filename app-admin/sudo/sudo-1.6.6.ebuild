# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.6.ebuild,v 1.18 2004/06/24 21:38:17 agriffis Exp $

DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/OLD/${P}.tar.gz"
HOMEPAGE="http://www.sudo.ws/"

SLOT="0"
LICENSE="Sudo"
KEYWORDS="x86 ppc sparc alpha hppa"
IUSE="pam"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )"

src_compile() {
	local myconf
	use pam \
		&& myconf="--with-pam" \
		|| myconf="--without-pam"

	econf --with-all-insults \
		--disable-path-info \
		--with-env-editor \
		${myconf} || die "econf failed"
	emake || die
}

src_install() {
	einstall
	dodoc BUGS CHANGES HISTORY LICENSE PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*
	insinto /etc/pam.d
	doins ${FILESDIR}/sudo
}
