# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/swatch/swatch-3.0.4.ebuild,v 1.1 2002/11/13 22:10:10 g2boojum Exp $

inherit perl-module

DESCRIPTION="Perl-based system log watcher"
HOMEPAGE="http://www.oit.ucsb.edu/~eta/swatch/"
SRC_URI="ftp://ftp.stanford.edu/general/security-tools/${PN}/${P}.tar.gz
         http://www.oit.ucsb.edu/~eta/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Date-Calc 
	dev-perl/TimeDate
	dev-perl/File-Tail
	>=dev-perl/Time-HiRes-1.12"
