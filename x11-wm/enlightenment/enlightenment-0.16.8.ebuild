# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.8.ebuild,v 1.3 2006/02/20 23:10:39 mholzer Exp $

inherit eutils

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/e16-${PV/_/-}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sh sparc x86"
IUSE="esd nls xinerama xrandr doc"

RDEPEND="esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-2*
	>=media-libs/imlib2-1.2.0
	!x11-misc/e16keyedit
	|| ( (
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXxf86vm
		xrandr? ( x11-libs/libXrandr )
		x11-libs/libXrender
		x11-misc/xbitmaps
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		xinerama? ( x11-libs/libXinerama x11-proto/xineramaproto )
		x11-proto/xproto
		) virtual/x11 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
PDEPEND="doc? ( app-doc/edox-data )"

S=${WORKDIR}/e16-${PV/_pre?}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable esd sound) \
		$(use_enable xinerama) \
		$(use_enable xrandr) \
		--enable-upgrade \
		--enable-hints-ewmh \
		--enable-fsstd \
		--enable-zoom \
		--with-imlib2 \
		|| die
	emake || die
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/e16 enlightenment

	dodoc AUTHORS ChangeLog INSTALL NEWS README* docs/README*
}
