# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.4.2-r4.ebuild,v 1.1 2003/11/26 16:26:03 usata Exp $

IUSE="X nopixbuf imlib imlib2 xface ssl migemo gpm cjk"
#IUSE="canna"

W3M_CVS_PV="1.890"
W3M_CVS_P="${PN}-cvs-${W3M_CVS_PV}"

DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="mirror://gentoo/${W3M_CVS_P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${W3M_CVS_P}.tar.gz
	http://www.page.sannet.ne.jp/knabe/w3m/${W3M_CVS_P}-async-3.diff.gz"
# canna? ( http://www.j10n.org/files/${W3M_CVS_P}-canna.patch )"

HOMEPAGE="http://w3m.sourceforge.net/"

SLOT="0"
LICENSE="w3m"
# since it is a CVS snapshot, we better not change keywords to stable
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"
# canna? ( app-i18n/canna )
RDEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	>=dev-libs/boehm-gc-6.2
	X? ( || ( !nopixbuf? ( >=media-libs/gdk-pixbuf-0.22.0 )
		imlib2? ( >=media-libs/imlib2-1.1.0-r2 )
		imlib? ( >=media-libs/imlib-1.9.8 )
		virtual/glibc )
	)
	!X? ( imlib2? ( >=media-libs/imlib2-1.1.0-r2 ) )
	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	migemo? ( >=app-text/migemo-0.40 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/textbrowser
	virtual/w3m"

S="${WORKDIR}/${PN}"

pkg_setup() {

	if [ -n "`use X`" -a -n "`use nopixbuf`" -a -z "`use imlib2`" -a -z "`use imlib`" ] ; then
		ewarn
		ewarn "If you set USE=\"nopixbuf\" (disable gdk-pixbuf for w3mimgdisplay),"
		ewarn "you need to enable either imlib2 or imlib USE flag."
		ewarn
		die "w3m requires gdk-pixbuf, imlib2 or imlib for image support."
	fi
}

src_unpack() {

	unpack ${W3M_CVS_P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PN}-w3mman-gentoo.diff
	epatch ${DISTDIR}/${W3M_CVS_P}-async-3.diff.gz
	epatch ${FILESDIR}/${PN}-async-gpm-gentoo.diff
	epatch ${FILESDIR}/${PN}-async-dlpanel-gentoo.diff
	#use canna && epatch ${DISTDIR}/${W3M_CVS_P}-canna.patch
}

src_compile() {

	export WANT_AUTOCONF_2_5=1
	#autoconf || die "autoconf failed"

	local myconf migemo_command imagelib

	if [ -n "`use X`" ] ; then
		myconf="${myconf} --enable-image=x11,fb `use_enable xface`"
		if [ ! -n "`use nopixbuf`" ] ; then
			imagelib="gdk-pixbuf"
		elif [ -n "`use imlib2`" ] ; then
			imagelib="imlib2"
		elif [ -n "`use imlib`" ] ; then
			imagelib="imlib"
		else
			# defaults to gdk-pixbuf
			imagelib="gdk-pixbuf"
		fi
	else
		if [ -n "`use imlib2`" ] ; then
			myconf="${myconf} --enable-image=fb"
			imagelib="imlib2"
		else
			myconf="${myconf} --enable-image=no"
			imagelib="no"
		fi
	fi

	if [ -n "`use migemo`" ] ; then
		migemo_command="migemo -t egrep /usr/share/migemo/migemo-dict"
	else
		migemo_command="no"
	fi

	if [ -n "`use cjk`" ] ; then
		myconf="${myconf}
			--enable-japanese=E
			--with-charset=EUC-JP"
	else
		myconf="${myconf}
			--with-charset=US-ASCII"
	fi

	# You can't disable cjk and nls at the moment(w3mhelper hangs)
	# `use_enable nls` `use_enable cjk`
	# You can't disable unicode(build fails)
	# `use_enable unicode`
	econf --enable-keymap=w3m \
		--with-editor=/usr/bin/nano \
		--with-mailer=/bin/mail \
		--with-browser=/usr/bin/mozilla \
		--with-termlib=ncurses \
		--with-imagelib="${imagelib}" \
		--with-migemo="${migemo_command}" \
		--enable-m17n \
		`use_enable gpm mouse` \
		`use_enable ssl digest-auth` \
		`use_with ssl` \
		${myconf} "$@" || die
		# `use_with canna`

	# emake borked
	make all || make all || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/${PN}/Bonus
	doins Bonus/*
	dodoc README NEWS TODO ChangeLog
	docinto doc-en ; dodoc doc/*
	if [ -n "`use cjk`" ] ; then
		docinto doc-jp ; dodoc doc-jp/*
	else
		rm -rf ${D}/usr/share/man/ja
	fi
}
