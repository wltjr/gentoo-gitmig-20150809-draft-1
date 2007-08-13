# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dzen/dzen-0.8.0.ebuild,v 1.1 2007/08/13 15:46:13 coldwind Exp $

inherit toolchain-funcs

SLOT="2"
MY_P="${PN}${SLOT}-${PV}"

DESCRIPTION="a general purpose messaging, notification and menuing program for
X11."
HOMEPAGE="http://gotmor.googlepages.com/dzen"
SRC_URI="http://gotmor.googlepages.com/${MY_P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86"
IUSE="xinerama"

RDEPEND="x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:/usr/local:/usr:g" \
		-e "s:-Os:${CFLAGS}:g" \
		-e "/CC/s:gcc:$(tc-getCC):" \
		-i config.mk || die "sed failed"
	sed -i -e "/strip/d" Makefile || die "sed failed"
	if use xinerama ; then
		sed -e "/^LIBS/s/$/\ -lXinerama/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XINERAMA/" \
			-i config.mk || die "sed failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die
}
