# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gstreamermm/gstreamermm-0.10.10.1.ebuild,v 1.1 2012/04/17 10:39:20 pacho Exp $

EAPI=4
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="C++ interface for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/bindings/cplusplus.html"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="
	>=media-libs/gstreamer-0.10.35:0.10
	>=media-libs/gst-plugins-base-0.10.35:0.10
	>=dev-cpp/glibmm-2.28.0:2
	>=dev-cpp/libxmlpp-2.14:2.6
	>=dev-libs/libsigc++-2:2
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? (
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-vorbis:0.10
		media-plugins/gst-plugins-x:0.10 )
"

DOCS="AUTHORS ChangeLog NEWS README"
# Installs reference docs into /usr/share/doc/gstreamermm-0.10/
# but that's okay, because the rest of dev-cpp/*mm stuff does the same
