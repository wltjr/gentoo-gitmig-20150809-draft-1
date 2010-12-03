# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AppConfig/AppConfig-1.66.ebuild,v 1.9 2010/12/03 02:21:25 xmw Exp $

EAPI=2

MODULE_AUTHOR=ABW
inherit perl-module eutils

DESCRIPTION="Perl5 module for reading configuration files and parsing command line arguments."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

DEPEND=">=dev-perl/File-HomeDir-0.57"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/blockdiffs.patch" )
SRC_TEST="do"
