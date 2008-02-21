# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.7.ebuild,v 1.1 2008/02/21 12:27:01 zaheerm Exp $

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/lame-3.95
	 >=media-libs/gstreamer-0.10.17
	 >=media-libs/gst-plugins-base-0.10.17"

DEPEND="${RDEPEND}"
