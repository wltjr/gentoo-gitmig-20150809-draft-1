# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/luma/luma-1.5.ebuild,v 1.2 2004/12/14 20:03:48 carlo Exp $

inherit eutils

DESCRIPTION="Luma is a graphical utility for accessing and managing data stored on LDAP servers."
HOMEPAGE="http://luma.sourceforge.net/"
SRC_URI="mirror://sourceforge/luma/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="samba"

RDEPEND=">=x11-libs/qt-3.2
	>=dev-lang/python-2.3
	>=dev-python/PyQt-3.10
	>=dev-python/python-ldap-2.0.1
	samba? ( >=dev-python/py-smbpasswd-1.0 )"
DEPEND=">=x11-libs/qt-3.2
	>=dev-lang/python-2.3
	>=dev-python/PyQt-3.10
	>=dev-python/python-ldap-2.0.1
	samba? ( >=dev-python/py-smbpasswd-1.0 )"

src_install() {
	dodir /usr
	python install.py --prefix=${D}/usr
}
