# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fxruby/fxruby-1.0.24.ebuild,v 1.2 2004/02/21 01:05:13 mr_bones_ Exp $

MY_P=FXRuby-${PV}
DESCRIPTION="Ruby language binding to the FOX GUI toolkit"
HOMEPAGE="http://www.fxruby.org/"
SRC_URI="mirror://sourceforge/fxruby/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha hppa sparc x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6
	>=x11-libs/fox-1.0"
S=${WORKDIR}/${MY_P}

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die

	dodoc ANNOUNCE ChangeLog README*
	cp -dr examples ${D}/usr/share/doc/${PF}
	dohtml -r doc/*
}
