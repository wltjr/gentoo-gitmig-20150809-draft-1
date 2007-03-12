# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/falconseye/falconseye-1.9.3-r1.ebuild,v 1.7 2007/03/12 17:15:10 genone Exp $

DESCRIPTION="A graphical version of nethack"
SRC_URI="mirror://sourceforge/falconseye/nethack_source_331_jtp_193.zip"
HOMEPAGE="http://falconseye.sourceforge.net/"

KEYWORDS="x86 ppc"
IUSE=""
LICENSE="nethack"
SLOT="0"

DEPEND="media-libs/libsdl
	dev-util/yacc
	app-arch/unzip"
RDEPEND="media-libs/libsdl
	app-arch/gzip
	media-sound/timidity++"

src_unpack() {
	unpack ${A}
	patch -p1 < ${FILESDIR}/${PV}-gzip.diff || die
	patch -p1 < ${FILESDIR}/${PV}-midiplayer.diff || die
	patch -p1 < ${FILESDIR}/${PV}-musicsavefix.diff || die
}

src_compile() {
	cd ${WORKDIR}/sys/unix
	source setup.sh
	cd ../../
	make PREFIX=/usr GAME=falconseye GAMEDIR=/usr/share/falconseye SHELLDIR=/usr/bin || die
	cd doc
	make || die
}

src_install() {
	cd ${WORKDIR}
	make PREFIX=${D}/usr GAME=falconseye GAMEDIR=${D}/usr/share/falconseye SHELLDIR=${D}/usr/bin install
	# Have to remake the shell script with real path information
	sed -e 's;/usr/games/lib/nethackdir;/usr/share/falconseye;' \
		-e 's;HACKDIR/nethack;HACKDIR/falconseye;' \
		-e '7a\
	if [[ -f ${HOME}/.falconseyerc ]] ; then\
	export NETHACKOPTIONS=${HOME}/.falconseyerc;\
	else\
	echo 'OPTIONS=noautopickup,toptenwin,showexp,rest_on_space' > ${HOME}/.falconseyerc;\
	export NETHACKOPTIONS=${HOME}/.falconseyerc;\
	fi' \
		< ${WORKDIR}/sys/unix/nethack.sh \
		> ${D}/usr/bin/falconseye
	cd doc
	doman *.6
}

pkg_postinst() {
	elog "Falconseye now supports a ~/.falconseyerc file to set options."
	elog "Click ? then 'List of game options' in falconseye for more info."
}
