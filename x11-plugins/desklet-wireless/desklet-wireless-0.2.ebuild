# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-wireless/desklet-wireless-0.2.ebuild,v 1.1 2004/07/18 09:34:26 obz Exp $

DESKLET_NAME="Wireless"

S=${WORKDIR}

DESCRIPTION="The wireless monitoring sensor and display for gDesklets"
SRC_URI="http://gdesklets.gnomedesktop.org/files/WirelessDisplay-${PV}.tar.gz
http://gdesklets.gnomedesktop.org/files/Install_Wireless_Sensor-${PV}.bin.bz2"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=69"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=gnome-extra/gdesklets-core-0.26
	>=net-wireless/wireless-tools-25"

src_install() {

	SYS_PATH="/usr/share/gdesklets"
	INSTALL_BIN="Install_${DESKLET_NAME}_Sensor-${PV}.bin"
	dodir ${SYS_PATH}/{Sensors,Displays}

	# first we install the Sensor
	python ${INSTALL_BIN} --nomsg ${D}${SYS_PATH}/Sensors

	# and then the .displays
	cd ${S}/WirelessDisplay
	insinto ${SYS_PATH}/Displays/${DESKLET_NAME}
	doins *.display

	# and finally the graphics
	cp -R gfx/ ${D}${SYS_PATH}/Displays/${DESKLET_NAME}

	# the desklets unpack preserves permissions of the archive
	chown -R root:root ${D}${SYS_PATH}/Sensors/${DESKLET_NAME}

}

