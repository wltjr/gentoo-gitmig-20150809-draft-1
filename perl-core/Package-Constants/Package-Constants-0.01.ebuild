# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Package-Constants/Package-Constants-0.01.ebuild,v 1.9 2008/11/04 09:55:42 vapier Exp $

MODULE_AUTHOR=KANE
inherit perl-module

DESCRIPTION="List all constants declared in a package"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST=do
