# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.6.8-r9.ebuild,v 1.1 2004/04/23 18:00:18 usata Exp $

IUSE="cjk"

ONIGURUMA="onigd2_2_6"
SNAP_DATE="20031015"

inherit flag-o-matic alternatives eutils
filter-flags -fomit-frame-pointer

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${PV%.*}/${P/_pre/-preview}.tar.gz
	mirror://gentoo/${P}-${SNAP_DATE}.diff.gz
	cjk? ( ftp://ftp.ruby-lang.org/pub/ruby/contrib/${ONIGURUMA}.tar.gz )"

LICENSE="Ruby"
SLOT="1.6"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~hppa ~amd64 -ia64 ~mips"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	>=dev-ruby/ruby-config-0.2"
PROVIDE="virtual/ruby"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ../${P}-${SNAP_DATE}.diff
	use amd64 && epatch ${FILESDIR}/${P}-fix-x86_64.patch

	if [ -n "`use cjk`" ] ; then
		einfo "Applying ${ONIGURUMA}"
		cd ${WORKDIR}/oniguruma
		econf --with-rubydir=${S}
		make ${SLOT/./}
	fi
}

src_compile() {
	econf --program-suffix=${SLOT/./} --enable-shared || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV%.*}
	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV}

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

pkg_postinst() {

	if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
		${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
	fi
	einfo
	einfo "You can change the default ruby interpreter by ${ROOT}usr/sbin/ruby-config"
	einfo
}

pkg_postrm() {

	if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
		${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
	fi
}
