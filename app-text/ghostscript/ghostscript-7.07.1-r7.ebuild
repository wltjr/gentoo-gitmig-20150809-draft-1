# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-7.07.1-r7.ebuild,v 1.6 2004/10/08 00:32:59 tester Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="ESP Ghostscript -- an enhanced version of GNU Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/ghostscript.php"
SRC_URI="mirror://sourceforge/espgs/espgs-${PV}-source.tar.bz2
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz)"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~ia64 x86 -ppc sparc alpha hppa amd64 ~mips ~ppc64"
IUSE="X cups cjk emacs truetype"

RDEPEND="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( virtual/x11 )
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	cups? ( net-print/cups )
	!virtual/ghostscript
	media-libs/fontconfig
	media-fonts/gnu-gs-fonts-std"

DEPEND="${RDEPEND}
	truetype? ( dev-util/pkgconfig )"

S=${WORKDIR}/espgs-${PV}

PROVIDE="virtual/ghostscript"

src_unpack() {
	unpack espgs-${PV}-source.tar.bz2

	cd ${S}

	if use cjk ; then
		epatch ${FILESDIR}/gs7.05.6-cjk.diff.bz2
		epatch ${FILESDIR}/gs7.05.6-kochi-substitute.patch
	fi

	# add fontconfig support
	epatch ${FILESDIR}/gs7.07.1-fontconfig-rh.patch.bz2

	# man page patch from absinthe@pobox.com (Dylan Carlson) bug #14150
	epatch ${FILESDIR}/ghostscript-7.05.6.man.patch

	# ijs fPIC patch
	epatch ${FILESDIR}/gs${PV}-ijs.patch

	# pxl dash patch
	epatch ${FILESDIR}/gs7.05.6-gdevpx.patch

	# Makefile.in fixes for DESTDIR support in libijs because
	# einstall borks on multilib systems -- eradicator
	epatch ${FILESDIR}/gs${PV}-ijsdestdir.patch

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/7.07/$(get_libdir):"\
	Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
	Makefile.in || die "sed failed"

	# insecure tempfile handling
	epatch ${FILESDIR}/gs${PV}-tempfile.patch

	# krgb support
	cd src
	epatch ${FILESDIR}/gs7.07.1-krgb.patch.gz
}

src_compile() {
	local myconf
	myconf="--with-ijs --with-omni --without-gimp-print"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use cups && myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"

	# -O3 will make ghostscript fail when compiling with gcc 3.4
	if [ "`gcc-major-version`" -eq "3" ] && [ "`gcc-minor-version`" -eq "4" ]
	then
		strip-flags
		replace-flags -O? -O2
	fi

	autoconf
	econf ${myconf} || die "econf failed"
	make || die "make failed"

	cd ijs
	econf || die "econf failed"
	make || die "make failed"
	cd ..
}

src_install() {
	einstall install_prefix=${D}

	rm -fr ${D}/usr/share/ghostscript/7.07/doc || die
	dodoc doc/README doc/COPYING doc/COPYING.LGPL
	dohtml doc/*.html doc/*.htm

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins doc/gsdoc.el
	fi

	if use cjk ; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# Install ijs
	cd ${S}/ijs
	dodir /usr/bin /usr/include /usr/$(get_libdir)
	# This is broken - there are not even a 'install_prefix'
	# anywhere in ${S}/ijs ...
	#einstall install_prefix=${D}
	#einstall
	#dosed "s:^prefix=.*:prefix=/usr:" /usr/bin/ijs-config
	make DESTDIR="${D}" install || die
}
