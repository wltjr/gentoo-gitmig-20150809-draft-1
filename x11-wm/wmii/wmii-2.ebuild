# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-2.ebuild,v 1.1 2005/08/12 15:36:22 tove Exp $

inherit eutils toolchain-funcs

DESCRIPTION="window manager improved 2 -- the next generation of the WMI project."
HOMEPAGE="http://www.wmii.net"
SRC_URI="http://wmi.modprobe.de/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="python"

DEPEND="virtual/x11
	python? ( dev-python/pyrex )"

src_unpack() {
	unpack "${A}"
	cd ${S}

	epatch "${FILESDIR}/${P}_050802.patch"

	sed -i \
		-e "/^PREFIX/s/=.*/= \/usr/" \
		-e "/^CONFPREFIX/s/=.*/= \/etc/" \
		-e "/^CC/s/=.*/= $(tc-getCC)/" \
		-e "/^AR/s/=.*/= $(tc-getAR) cr/" \
		-e "/^RANLIB/s/=.*/= $(tc-getRANLIB)/" \
		-e "/^CFLAGS/s/-O0/${CFLAGS}/" \
		-e "/^LDFLAGS/s/-g /-g ${LDFLAGS} /" \
		"${S}/config.mk" || die "sed failed."
}

src_compile() {
	emake || die "emake failed"

	if useq python ; then
		cd "${S}"/libixp/python
		python setup.py build || die "python build failed."
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."

	dodoc ANNOUNCE || die "ANNOUNCE failed." # only in releases
	dodoc CHANGES README LICENSE doc/welcome.txt || die "dodoc failed."

	if useq python ; then
		cd "${S}"/libixp/python
		python setup.py install --root="${D}" || die "python install failed."
	fi

#	insinto /usr/share/"${PN}"/contrib
#	doins "${S}"/contrib/README || die "contrib README failed."
#	exeinto /usr/share/"${PN}"/contrib
#	doexe "${S}"/contrib/*.py || die "contrib failed."

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}" || die "/etc/X11/Sessions failed."

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop" || die "${PN}.desktop failed."
}
