# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.6.ebuild,v 1.2 2008/04/13 14:52:28 hollow Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND="=net-misc/neon-0.26*
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
