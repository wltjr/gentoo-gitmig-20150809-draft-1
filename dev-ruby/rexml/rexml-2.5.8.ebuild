# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexml/rexml-2.5.8.ebuild,v 1.3 2004/02/22 22:23:27 agriffis Exp $

MY_P="${PN}_${PV}"
DESCRIPTION="An XML parser for Ruby, in Ruby"
HOMEPAGE="http://www.germane-software.com/software/rexml"
SRC_URI="http://www.germane-software.com/archives/${MY_P}.tgz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa mips sparc x86"
DEPEND=">=dev-lang/ruby-1.6"
S=${WORKDIR}/${MY_P}

src_install() {
	ruby bin/install.rb --destdir=${D} || die
	dodoc README
	# Use insinto/doins to avoid compressing html files
	insinto /usr/share/doc/${P}
	doins *.html
	dohtml -r doc/*
}
