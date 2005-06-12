# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/specimen/specimen-0.4.1.ebuild,v 1.5 2005/06/12 12:14:14 swegener Exp $

DESCRIPTION="A Midi Controllable Audio Sampler"
HOMEPAGE="http://www.gazuga.net"
SRC_URI="http://www.gazuga.net/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
#-amd64: 0.4.1: int/pointer casting
KEYWORDS="x86 ~ppc -amd64"

IUSE="ladcca debug"

DEPEND="media-sound/jack-audio-connection-kit
	virtual/alsa
	media-libs/libsamplerate
	media-libs/libsndfile
	dev-libs/libxml2
	>x11-libs/gtk+-2
	gnome-base/libgnomecanvas
	ladcca? ( media-libs/ladcca )"

src_compile() {
	local myconf;
	use ladcca || myconf="${myconf} --disable-ladcca"
	use debug || myconf="${myconf} --disable-debug"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	#dobin src/specimen
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
