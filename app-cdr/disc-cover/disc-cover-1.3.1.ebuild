# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Felix Kurth <felix@fkurth.de>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/disc-cover/disc-cover-1.3.1.ebuild,v 1.2 2002/06/19 00:29:02 agenkin Exp $

DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"
HOMEPAGE="http://www.liacs.nl/~jvhemert/disc-cover/"

DEPEND=">=dev-perl/Audio-CD-disc-cover-0.04
	>=app-text/tetex-1.0.7-r7"
	
SRC_URI="http://www.liacs.nl/~jvhemert/disc-cover/download/unstable/${P}.tar.gz"

src_compile () {
	pod2man disc-cover > disc-cover.1 || die
}

src_install () {
	into /usr
	dobin disc-cover
	doman disc-cover.1

	dodoc AUTHORS CHANGELOG COPYING TODO
	docinto freedb
	dodoc freedb/*
	docinto docs
	docinto docs/english
	dodoc docs/english/*
	docinto docs/dutch
	dodoc docs/dutch/*
	docinto docs/german
	dodoc docs/german/*
	docinto docs/spanish
	dodoc docs/spanish/*
}
