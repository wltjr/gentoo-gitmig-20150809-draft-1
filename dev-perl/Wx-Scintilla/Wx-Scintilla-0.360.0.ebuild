# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Wx-Scintilla/Wx-Scintilla-0.360.0.ebuild,v 1.1 2011/12/25 10:21:35 tove Exp $

EAPI=4

WX_GTK_VER="2.8"
#VIRTUALX_REQUIRED=test
#inherit virtualx
MODULE_AUTHOR=AZAWAWI
MODULE_VERSION=0.36
inherit wxwidgets perl-module

DESCRIPTION="Scintilla source code editing component for wxWidgets"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/dev-perl/${PN}-0.34-patches.tar.gz"

LICENSE+=" Scintilla"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Alien-wxWidgets
	dev-perl/wxperl
"
DEPEND="${RDEPEND}
	>=dev-perl/ExtUtils-XSpp-0.160.200
	>=virtual/perl-Module-Build-0.360.0
"

PATCHES=(
	"${WORKDIR}"/${PN}-patches/0.34-flags.patch
)

#SRC_TEST=do
#src_test() {
#	VIRTUALX_COMMAND="./Build" virtualmake test || die
#}
