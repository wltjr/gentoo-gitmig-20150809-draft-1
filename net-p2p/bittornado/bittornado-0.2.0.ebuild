# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit distutils
inherit eutils

MY_PN="BitTornado"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TheShad0w's experimental BitTorrent client"
HOMEPAGE="http://www.bittornado.com/"
SRC_URI="http://e.scarywater.net/bt/download/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="X"

RDEPEND="X? ( >=dev-python/wxPython-2.2 )
	 >=dev-lang/python-2.0
	 !virtual/bittorrent"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"

PROVIDE="virtual/bittorrent"

S="${WORKDIR}/${MY_PN}-CVS"
PIXMAPLOC="/usr/share/pixmaps/bittornado"

src_unpack() {
	unpack ${A}

	# fixes wrong icons path
	sed -i "s:os.path.abspath(os.path.dirname(os.path.realpath(sys.argv\[0\]))):\"${PIXMAPLOC}/\":" ${S}/btdownloadgui.py
}

src_install() {
	distutils_src_install

	dodir etc
	cp -a /etc/mailcap ${D}/etc/
	MAILCAP_STRING="application/x-bittorrent; /usr/bin/btdownloadgui.py '%s'; test=test -n \"\$DISPLAY\""

	rm ${D}/usr/bin/*.ico
	rm ${D}/usr/bin/*.gif

	if use X; then
		dodir ${PIXMAPLOC}
		insinto ${PIXMAPLOC}
		doins *.ico *.gif
		if [ -n "`grep 'application/x-bittorrent' ${D}/etc/mailcap`" ]; then
			# replace bittorrent entry if it already exists
			einfo "updating bittorrent mime info"
			sed -i "s,application/x-bittorrent;.*,${MAILCAP_STRING}," ${D}/etc/mailcap
		else
			# add bittorrent entry if it doesn't exist
			einfo "adding bittorrent mime info"
			echo "${MAILCAP_STRING}" >> ${D}/etc/mailcap
		fi
	else
		# get rid of any reference to the not-installed gui version
		sed -i '/btdownloadgui/d' ${D}/etc/mailcap
		rm ${D}/usr/bin/*gui.py
	fi
}

