# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-cornerxmms/desklet-cornerxmms-0.0.5-r1.ebuild,v 1.3 2004/04/12 16:42:32 aliz Exp $

DESKLET_NAME="CornerXMMS"

MY_PN=${DESKLET_NAME}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A corner display that interacts with XMMS"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~sparc ~ppc amd64"

DEPEND=">=gnome-extra/gdesklets-core-0.22
	>=dev-python/pyxmms-1.06"

DOCS="Changelog README TODO"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	# and then the .displays
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display

	# and finally the graphics
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}/gfx
	doins gfx/*
	chmod 644 ${D}${SYS_PATH}/Displays/${DESKLET_NAME}/gfx/*.png

	dodoc ${DOCS}

	# the desklets unpack preservers permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}

