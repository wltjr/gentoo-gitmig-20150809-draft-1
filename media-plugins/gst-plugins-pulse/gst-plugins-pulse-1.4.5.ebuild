# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-1.4.5.ebuild,v 1.9 2015/07/30 13:23:41 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer plugin for the PulseAudio sound server"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~sh sparc x86"
IUSE=""

RDEPEND=">=media-sound/pulseaudio-2.1-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
