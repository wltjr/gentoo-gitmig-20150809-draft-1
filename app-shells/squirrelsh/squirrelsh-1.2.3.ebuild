# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/squirrelsh/squirrelsh-1.2.3.ebuild,v 1.2 2009/09/01 06:40:15 fauli Exp $

EAPI="2"

inherit eutils multilib toolchain-funcs

DESCRIPTION="An advanced, cross-platform object oriented scripting shell based
on the squirrel scripting language"
HOMEPAGE="http://squirrelsh.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc static"

DEPEND="dev-libs/libpcre"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Fix pre-stripping
	sed -i -e '/in_LFLAGS="-s $in_LFLAGS"/d' configure || die "sed failed"
	#Fix multilib issues
	sed -i -e "s:prefix/lib:prefix/$(get_libdir):" configure || die "sed failed"
	#Fix CFLAG madness
	sed -i -e "s:-O2 -Os -Wall -ffast-math:${CFLAGS}:" \
		configure || die "sed failed"
	sed -i -e "s:\$c_compiler_flags -fno-rtti:${CXXFLAGS}:" \
		configure || die "sed failed"
	sed -i -e "s:-fomit-frame-pointer::" configure || die "sed failed"
	sed -i -e "797,817d" configure || die "sed failed"
	#Fix compiler madness
	sed -i -e "s:c_compiler=\"gcc\":c_compiler=\"$(tc-getCC)\":" \
		configure || die "sed failed"
	sed -i -e "s:cpp_compiler=\"g++\":cpp_compiler=\"$(tc-getCXX)\":" \
		configure || die "sed failed"
	#Remove autoinstallation of docs
	sed -i -e "/@INSTALL@/d" Makefile.in || die "sed failed"
}

src_configure() {
	use static && \
		confline="--with-libraries=static" || \
		confline="--with-libraries=shared"

	#Not autotools, custom rolled
	./configure --prefix="${D}"/usr \
		--with-mime=no ${confline} || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	doman doc/${PN}.1 || die "doman failed"
	dodoc HISTORY INSTALL README || die "dodoc failed"
	if use doc ; then
		dodoc doc/*.pdf || die "dodoc failed"
	fi
}
