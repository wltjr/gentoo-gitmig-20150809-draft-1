# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/popick/popick-0.1.ebuild,v 1.3 2005/05/25 14:04:12 mcummings Exp $

inherit eutils

DESCRIPTION="A POP3 mailbox deleter that allows you to interactively specify regular expressions to match the message headers, and delete matching messages."
HOMEPAGE="http://www.topfx.com"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/Curses-UI
	perl-core/Getopt-Long"


src_unpack() {
	unpack ${A}
	cd ${S}
	mv popick.pl popick || die "Renaming popick.pl to popick"
	sed -i -e 's:/usr/local:/usr:g' $(grep -rl /usr/local *) || die "sed /usr/local failed"
}

src_compile() {
	# No compiling needed :)
	pod2man popick > popick.1 || die "Generating manpage failed"
}

src_install() {
	dobin popick
	doman popick.1
}
