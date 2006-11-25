# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity++/timidity++-2.13.2-r3.ebuild,v 1.2 2006/11/25 11:22:50 genstef Exp $

inherit eutils

MY_PV=${PV/_/-}
MY_P=TiMidity++-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A handy MIDI to WAV converter with OSS and ALSA output support"
HOMEPAGE="http://timidity.sourceforge.net/"
SRC_URI="mirror://sourceforge/timidity/${MY_P}.tar.bz2 mirror://gentoo/${P}-exiterror.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="oss nas esd motif X gtk gtk vorbis tcltk slang alsa arts jack portaudio emacs ao speex flac ncurses"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.0 )
	gtk? ( >=x11-libs/gtk+-2.0 )
	tcltk? ( >=dev-lang/tk-8.1 )
	motif? ( virtual/motif )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( >=media-libs/nas-1.4 )
	alsa? ( media-libs/alsa-lib )
	slang? ( =sys-libs/slang-1.4* )
	arts? ( kde-base/arts )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( media-libs/portaudio )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	flac? ( ~media-libs/flac-1.1.2 )
	speex? ( >=media-libs/speex-1.1.5 )
	ao? ( >=media-libs/libao-0.8.5 )"

RDEPEND="${RDEPEND}
	app-admin/eselect-timidity
	emacs? ( virtual/emacs )"

PDEPEND="|| ( media-sound/timidity-eawpatches media-sound/timidity-shompatches )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}/${P}-exiterror.patch"
	epatch "${FILESDIR}/${P}-gtk26.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"

	# fix header location of speex
	sed -i -e "s:#include <speex:#include <speex/speex:g" configure* timidity/speex_a.c
}

src_compile() {
	local myconf
	local audios

	use flac && audios="${audios},flac"
	use speex && audios="${audios},speex"
	use vorbis && audios="${audios},vorbis"

	use oss && audios="${audios},oss"
	use esd && audios="${audios},esd"
	use arts && audios="${audios},arts"
	use jack && audios="${audios},jack"
	use portaudio && use !ppc && audios="${audios},portaudio"
	use ao && audios="${audios},ao"

	if use nas; then
		audios="${audios},nas"
		myconf="${myconf} --with-nas-library=/usr/$(get_libdir)/libaudio.so"
	fi

	if use alsa; then
		audios="${audios},alsa"
		myconf="${myconf} --with-default-output=alsa --enable-alsaseq"
	fi

	econf \
		--localstatedir=/var/state/timidity++ \
		--with-elf \
		--enable-audio=${audios} \
		--enable-server \
		--enable-network \
		--enable-dynamic \
		--enable-vt100 \
		--enable-spline=cubic \
		$(use_enable emacs) \
		$(use_enable slang) \
		$(use_enable ncurses) \
		$(use_with X x) \
		$(use_enable X spectrogram) \
		$(use_enable X wrd) \
		$(use_enable X xskin) \
		$(use_enable X xaw) \
		$(use_enable gtk) \
		$(use_enable motif) \
		$(use_enable tcltk) \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog*
	dodoc NEWS README* "${FILESDIR}/timidity.cfg"

	# these are only for the ALSA sequencer mode
	if use alsa; then
		newconfd "${FILESDIR}/conf.d.timidity" timidity
		newinitd "${FILESDIR}/init.d.timidity" timidity
	fi

	insinto /etc
	newins "${FILESDIR}/timidity.cfg-r1" timidity.cfg

	dodir /usr/share/timidity
	dosym /etc/timidity.cfg /usr/share/timidity/timidity.cfg

	if use emacs ; then
		dosed 's:/usr/local/bin/timidity:/usr/bin/timidity:g' /usr/share/emacs/site-lisp/timidity.el
	else
		rm "${D}/timidity.el"
	fi
}

pkg_postinst() {
	elog "A timidity config file has been installed in /etc/timidity.cfg."
	elog "Do not edit this file as it will interfere with the eselect timidity tool."
	elog "The tool 'eselect timidity' can be used to switch between installed patchsets."

	if use alsa; then
		elog "An init script for the alsa timidity sequencer has been installed."
		elog "If you wish to use the timidity virtual sequencer, edit /etc/conf.d/timidity"
		elog "and run 'rc-update add timidity <runlevel> && /etc/init.d/timidity start'"
	fi

	if use sparc; then
		ewarn "sparc support is experimental. oss, alsa, esd, and portaudio do not work."
		ewarn "-Ow (save to wave file) does..."
	fi
}
