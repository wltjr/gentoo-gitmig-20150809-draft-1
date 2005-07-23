# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-1.0.6-r2.ebuild,v 1.3 2005/07/23 16:07:23 gmsoft Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/source/firefox-${PV}-source.tar.bz2
	mirror://gentoo/mozilla-firefox-1.0-4ft2.patch.bz2
	mirror://gentoo/mozilla-firefox-1.0.3-ia64.patch.bz2
	mirror://gentoo/mozilla-jslibmath-alpha.patch
	mirror://gentoo/mozilla-firefox-1.0.6-nsplugins.patch
	http://dev.gentoo.org/~agriffis/dist/mozilla-firefox-1.0.6-nsplugins.patch"

KEYWORDS="alpha amd64 ~arm hppa ia64 ppc sparc x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="gnome java mozdevelop mozsvg mozcalendar"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	>=media-libs/libmng-1.0.0
	mozsvg? (
		>=x11-base/xorg-x11-6.7.0-r2
		x11-libs/cairo
	)
	>=www-client/mozilla-launcher-1.39"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
export MOZ_PHOENIX=1

src_unpack() {
	declare x

	for x in ${A}; do
		[[ $x == *.tar.* ]] || continue
		unpack $x || die "unpack failed"
	done
	cd ${S} || die "cd failed"

	####################################
	#
	# architecture patches
	#
	####################################

	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/mozilla-1.3-alpha-stubs.patch

	# hppa patches from Ivar <orskaug@stud.ntnu.no>
	# <gmsoft@gentoo.org> (22 Dec 2004)
	epatch ${FILESDIR}/mozilla-hppa.patch

	# patch to solve segfaults on ia64, from Debian, originally from David
	# Mosberger
	epatch ${DISTDIR}/mozilla-firefox-1.0.3-ia64.patch.bz2

	# patch to fix math operations on alpha, makes maps.google.com work!
	epatch ${DISTDIR}/mozilla-jslibmath-alpha.patch

	####################################
	#
	# general compilation and run-time fixes
	#
	####################################

	# GCC4 compile fix, bug #87800
	epatch ${FILESDIR}/mozilla-firefox-1.0.4-gcc4.patch

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${DISTDIR}/mozilla-firefox-1.0-4ft2.patch.bz2

	# Patch for newer versions of cairo #80301
	if has_version '>=x11-libs/cairo-0.3.0'; then
		epatch ${FILESDIR}/svg-cairo-0.3.0-fix.patch
	fi

	####################################
	#
	# behavioral fixes
	#
	####################################

	# patch to fix separate character on euro keyboards, bug 68995
	epatch ${FILESDIR}/mozilla-firefox-1.0-kp_separator.patch

	# some patches from Debian to set default preferences:
	# - inherit LANG from env
	# - shut off SSLv2 and 40-bit ciphers by default
	# - disable application auto-updating
	epatch ${FILESDIR}/mozilla-firefox-1.0.3-prefs.patch

	# look in /usr/lib/nsplugins for plugins, in addition to the usual places
	epatch ${DISTDIR}/mozilla-firefox-1.0.6-nsplugins.patch
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml

	# Other ff-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_use_enable gnome gnomevfs
	mozconfig_use_extension gnome gnomevfs
	mozconfig_use_enable mozcalendar calendar
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-cairo
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	#mozconfig_annotate '' --with-user-appdir=.firefox

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	has_hardened && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build
	#
	####################################

	LD="$(tc-getLD)" CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
	econf || die

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/firefox
	install_mozilla_launcher_stub firefox ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/firefox-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillafirefox.desktop

	# Fix icons to look the same everywhere
	insinto ${MOZILLA_FIVE_HOME}/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	####################################
	#
	# Install files necessary for applications to build against firefox
	#
	####################################

	einfo "Installing includes and idl files..."
	dodir ${MOZILLA_FIVE_HOME}/include/idl /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}${MOZILLA_FIVE_HOME}/include
	cp -LfR idl/* ${D}${MOZILLA_FIVE_HOME}/include/idl

	# Dirty hack to get some applications using this header running
	dosym ${MOZILLA_FIVE_HOME}/include/necko/nsIURI.h \
		/usr/lib/${MOZILLA_FIVE_HOME##*/}/include/nsIURI.h

	# Compatibility symlink so that applications can still build against firefox
	# even though it has moved.  To remove this symlink, grep -r MozillaFirefox
	# /usr/portage and fix those ebuilds
	dosym ${MOZILLA_FIVE_HOME##*/} ${MOZILLA_FIVE_HOME%/*}/MozillaFirefox

	# Fix firefox-config and install it
	sed -i -e "s|/usr/lib/firefox-${PV}|${MOZILLA_FIVE_HOME}|g
		s|/usr/include/firefox-${PV}|${MOZILLA_FIVE_HOME}/include|g" \
		${S}/build/unix/firefox-config
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${S}/build/unix/firefox-config

	# Fix pkgconfig files and install them
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|" ${x}
		doins ${x}
	done

	# Install env.d snippet, which isn't necessary for running firefox, but
	# might be necessary for programs linked against firefox
	insinto /etc/env.d
	doins ${FILESDIR}/10MozillaFirefox
	dosed "s|/usr/lib|/usr/$(get_libdir)|" /etc/env.d/10MozillaFirefox

	# Install docs
	dodoc LEGAL LICENSE
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=firefox \
		/usr/libexec/mozilla-launcher -register

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=firefox \
		/usr/libexec/mozilla-launcher -register

	update_mozilla_launcher_symlinks
}
