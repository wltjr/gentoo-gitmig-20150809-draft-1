# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Notify/Gtk2-Notify-0.05-r1.ebuild,v 1.2 2015/05/01 12:03:17 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=FLORA

inherit perl-module virtualx

DESCRIPTION="A perl interface to the notification library"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-perl/glib-perl
	dev-perl/gtk2-perl
	>=x11-libs/libnotify-0.7"
DEPEND="${RDEPEND}
	dev-perl/ExtUtils-Depends
	dev-perl/extutils-pkgconfig
	test? ( dev-perl/Test-Exception )"

SRC_TEST="do"

PATCHES=( "${FILESDIR}"/${P}-libnotify.patch )

src_test() {
	VIRTUALX_COMMAND="perl-module_src_test" virtualmake #416729
}
