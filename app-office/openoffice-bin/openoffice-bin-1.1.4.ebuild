# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.1.4.ebuild,v 1.13 2005/01/29 20:15:15 suka Exp $

# NOTE:  There are two big issues that should be addressed.
#
#        1)  Language support and fonts should be addressed.

IUSE="gnome java kde"

INSTDIR="/opt/OpenOffice.org"
MY_P="OOo_${PV}_LinuxIntel_install"

S="${WORKDIR}/${MY_P}"
DESCRIPTION="OpenOffice productivity suite"

SRC_URI="x86? ( mirror://openoffice/stable/${PV}/OOo_${PV}_LinuxIntel_install.tar.gz ) \
		 amd64? (mirror://openoffice/stable/${PV}/OOo_${PV}_LinuxIntel_install.tar.gz )"

HOMEPAGE="http://www.openoffice.org/"

LICENSE="|| ( LGPL-2  SISSL-1.1 )"
SLOT="0"
KEYWORDS="x86 ~amd64"

RDEPEND="!app-office/openoffice
	virtual/x11
	virtual/libc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	java? ( >=virtual/jre-1.4.1 )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"

src_install() {
	# Sandbox issues; bug #8587
	addpredict "/user"
	addpredict "/share"
	addpredict "/dev/dri"
	addpredict "/usr/bin/soffice"
	addpredict "/pspfontcache"
	addpredict "/root/.gconfd"
	addpredict "/opt/OpenOffice.org/foo.tmp"
	addpredict "/opt/OpenOffice.org/delme"

	# Autoresponse file for main installation
	cat > ${T}/rsfile-global <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_NETWORK
		INSTALLATIONTYPE=STANDARD
		DESTINATIONPATH=<destdir>
		OUTERPATH=
		LOGFILE=
		LANGUAGELIST=<LANGUAGE>

		[JAVA]
		JavaSupport=preinstalled_or_none
	END_RS

	# Autoresponse file for user installation
	cat > ${T}/rsfile-local <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_WORKSTATION
		INSTALLATIONTYPE=WORKSTATION
		DESTINATIONPATH=<home>/.openoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse || die

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}
	./setup -v -noexit -nogui -r:${T}/autoresponse || die "Setup failed"

	einfo "Removing build root from registry..."
	# Remove totally useless stuff.
	rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh} || die
	# Remove build root from registry and co
	egrep -rl "${D}" ${D}${INSTDIR}/* | \
		xargs -i perl -pi -e "s|${D}||g" {} || :

	einfo "Fixing permissions..."
	# Fix permissions
	find ${D}${INSTDIR}/ -type f -exec chmod a+r {} \;
	chmod a+x ${D}${INSTDIR}/share/config/webcast/*.pl

	# Install user autoresponse file
	insinto /etc/openoffice
	sed -e "s|<pv>|${PV}|g" ${T}/rsfile-local > ${T}/autoresponse-${PV}.conf
	doins ${T}/autoresponse-${PV}.conf

	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${PV}|g" \
		${FILESDIR}/${PV}/ooffice-wrapper-1.3 > ${T}/ooffice
	doexe ${T}/ooffice

	# Component symlinks
	for app in calc draw impress math writer web setup padmin; do
		dosym ooffice /usr/bin/oo${app}
	done

	einfo "Installing Menu shortcuts (need \"gnome\" or \"kde\" in USE)..."
	if use gnome
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the category
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order

		# Change this to ooo*.desktop from *.desktop for now, since
		# otherwise two sets of icons will appear in the GNOME menu.
		# <brad@gentoo.org> (04 Aug 2003)
		for x in ${D}${INSTDIR}/share/gnome/net/ooo*.desktop
		do
			# We have to handle soffice and setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			perl -pi -e "s:${INSTDIR}/program/soffice:/usr/bin/ooffice:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	if use kde
	then
		local kdeloc="${D}${INSTDIR}/share/kde/net/"

		insinto /usr/share/applnk/OpenOffice.org\ 1.1
		# Install the files needed for the category
		doins ${kdeloc}/.directory
		dodir /usr/share
		# Install the icons and mime info
		cp -a ${D}${INSTDIR}/share/kde/net/share/mimelnk ${D}${INSTDIR}/share/kde/net/share/icons ${D}/usr/share

		for x in ${kdeloc}/*.desktop
		do
			# We have to handle soffice and setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			perl -pi -e "s:${INSTDIR}/program/soffice:/usr/bin/ooffice:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi


	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde || die

	# Fix instdb.ins, to *not* install local copies of these
	for entry in Kdeapplnk Kdemimetext Kdeicons Gnome_Apps Gnome_Icons Gnome2_Apps; do
		perl -pi -e "/^File gid_File_Extra_$entry/ .. /^End/ and (\
			s|^\tSize\s+\= .*|\tSize\t\t = 0;\r| or \
			s|^\tArchiveFiles\s+\= .*|\tArchiveFiles\t = 0;\r| or \
			s|^\tArchiveSize\s+\= .*|\tArchiveSize\t = 0;\r| or \
			s|^\tContains\s+\= .*|\tContains\t = ();\r| or \
			s|\t\t\t\t\t\".*|\r|g)" \
			${D}${INSTDIR}/program/instdb.ins
	done

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb} ${INSTDIR}/user/psprint/{driver,fontmetric} ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}

	#touch files to make portage uninstalling happy (#22593)
	find ${D} -type f -exec touch {} \;
}

pkg_postinst() {

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb or oowriter"
}

