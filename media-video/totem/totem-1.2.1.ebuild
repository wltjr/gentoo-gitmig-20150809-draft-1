# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-1.2.1.ebuild,v 1.11 2006/02/27 14:59:27 zaheerm Exp $

inherit autotools eutils multilib gnome2

DESCRIPTION="Media player for GNOME"
HOMEPAGE="http://gnome.org/projects/totem/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="a52 dvd flac gnome lirc mad mpeg nsplugin ogg theora vorbis win32codecs xine xv"

RDEPEND=">=dev-libs/glib-2.6.3
	>=x11-libs/gtk+-2.6
	>=gnome-base/gnome-vfs-2.9.92
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libgnomeui-2.4
	>=x11-themes/gnome-icon-theme-2.10
	app-text/iso-codes
	media-libs/musicbrainz
	gnome? ( >=gnome-base/nautilus-2.10 )
	lirc? ( app-misc/lirc )
	xine? (
		>=media-libs/xine-lib-1.0.1
		>=gnome-base/gconf-2 )
	!xine? (
		|| ( =media-libs/gstreamer-0.8.10 =media-libs/gstreamer-0.8.11
		=media-libs/gstreamer-0.8.12 )
		=media-libs/gst-plugins-0.8*
		=media-plugins/gst-plugins-gnomevfs-0.8*
		=media-plugins/gst-plugins-pango-0.8*
		|| ( =media-plugins/gst-plugins-ffmpeg-0.8.6
			~media-plugins/gst-plugins-ffmpeg-0.8.7 )
		mad? ( =media-plugins/gst-plugins-mad-0.8* )
		mpeg? ( =media-plugins/gst-plugins-mpeg2dec-0.8* )
		ogg? ( =media-plugins/gst-plugins-ogg-0.8* )
		xv? ( =media-plugins/gst-plugins-xvideo-0.8* )
		vorbis? (
			=media-plugins/gst-plugins-ogg-0.8*
			=media-plugins/gst-plugins-vorbis-0.8* )
		a52? ( =media-plugins/gst-plugins-a52dec-0.8* )
		flac? ( =media-plugins/gst-plugins-flac-0.8* )
		theora? (
			=media-plugins/gst-plugins-ogg-0.8*
			=media-plugins/gst-plugins-theora-0.8* )
		mad? ( =media-plugins/gst-plugins-mad-0.8* )
		!sparc? ( dvd? (
			=media-plugins/gst-plugins-a52dec-0.8*
			=media-plugins/gst-plugins-dvdread-0.8*
			=media-plugins/gst-plugins-mpeg2dec-0.8*
			|| ( =media-plugins/gst-plugins-dvdnav-0.8.11
			=media-plugins/gst-plugins-dvdnav-0.8.12 ) ) )
		win32codecs? ( =media-plugins/gst-plugins-pitfdll-0.8* ) )
	nsplugin? (
		>=net-libs/gecko-sdk-1.7
		>=sys-apps/dbus-0.35 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="--disable-gtk \
		$(use_enable lirc)             \
		$(use_enable gnome nautilus)   \
		$(use_enable nsplugin mozilla) \
		$(use_with nsplugin mozilla gecko-sdk)"

	# gstreamer is default backend
	use xine || G2CONF="${G2CONF} --enable-gstreamer"

	# Use global nsplugins dir
	G2CONF="${G2CONF} MOZILLA_PLUGINDIR=/usr/$(get_libdir)/nsbrowser"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Recognize gecko-sdk as a valid toolkit to compile the plugin
	epatch ${FILESDIR}/${PN}-1.2.1-gecko-sdk.patch
	eautoreconf

	gnome2_omf_fix help/*/Makefile.in
}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Note that the default totem backend has switched to gstreamer."
	einfo "DVD menus will only work with the xine backend."

}
