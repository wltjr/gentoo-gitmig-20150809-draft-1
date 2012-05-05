# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.22.12_pre2.ebuild,v 1.5 2012/05/05 07:00:20 jdhore Exp $

EAPI="2"

inherit nsplugins eutils flag-o-matic java-pkg-opt-2

DESCRIPTION="VRML97 and X3D compliant browser, library, and web-browser plugin"
SRC_URI="mirror://sourceforge/freewrl/${P}.tar.bz2"
HOMEPAGE="http://freewrl.sourceforge.net/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug expat +glew java libeai motif +nsplugin osc +sox static-libs"

COMMONDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libX11
	motif? ( x11-libs/openmotif )
	!motif? ( x11-libs/libXaw )
	media-libs/mesa
	glew? ( media-libs/glew )
	virtual/opengl
	media-libs/libpng
	virtual/jpeg
	media-libs/imlib2
	>=media-libs/freetype-2
	media-libs/fontconfig
	curl? ( net-misc/curl )
	expat? ( dev-libs/expat )
	osc? ( media-libs/liblo )
	dev-lang/spidermonkey"
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	java? ( >=virtual/jdk-1.4 )
	nsplugin? ( =net-misc/npapi-sdk-0.27 )"
RDEPEND="${COMMONDEPEND}
	media-fonts/dejavu
	|| ( media-gfx/imagemagick
		media-gfx/graphicsmagick[imagemagick] )
	app-arch/unzip
	java? ( >=virtual/jre-1.4 )
	sox? ( media-sound/sox )"

src_configure() {
	local myconf="--enable-fontconfig
		--with-x
		--with-imageconvert=/usr/bin/convert
		--with-unzip=/usr/bin/unzip"
	if use motif; then
		myconf="${myconf} --with-target=motif --with-statusbar=standard"
	else
		myconf="${myconf} --with-target=x11 --with-statusbar=hud"
	fi
	if use nsplugin; then
		myconf="${myconf} --with-plugindir=/usr/$(get_libdir)/${PLUGINS_DIR}"
		# override auto-detection for npapi headers, can be removed for next upstream release
		myconf="${myconf} --disable-mozilla-plugin --disable-xulrunner-plugin --disable-seamonkey-plugin --disable-firefox-plugin"
		MOZILLA_PLUGIN_CFLAGS="$(pkg-config --cflags npapi-sdk)"
		MOZILLA_PLUGIN_LIBS="$(pkg-config --libs npapi-sdk)"
		export MOZILLA_PLUGIN_CFLAGS
		export MOZILLA_PLUGIN_LIBS
	fi
	if use sox; then
		myconf="${myconf} --with-soundconv=/usr/bin/sox"
	fi
	# disable the checks for other js libs, in case they are installed
	if has_version ">=dev-lang/spidermonkey-1.8.5" ; then
		# spidermonkey-1.8.5 provides a .pc to pkg-config, it should be findable via mozjs185
		myconf="${myconf} --disable-mozilla-js --disable-xulrunner-js --disable-firefox-js --disable-seamonkey-js --disable-firefox2-js"
	else
		myconf="${myconf} --disable-mozjs185 --disable-mozilla-js --disable-xulrunner-js --disable-firefox-js --disable-seamonkey-js"
		# spidermonkey pre-1.8.5 has no pkg-config, so override ./configure
		JAVASCRIPT_ENGINE_CFLAGS="-I/usr/include/js -DXP_UNIX"
		if has_version ">=dev-lang/spidermonkey-1.8" ; then
			# spidermonkey-1.8 changed the name of the lib
			JAVASCRIPT_ENGINE_LIBS="-lmozjs"
		else
			JAVASCRIPT_ENGINE_LIBS="-ljs"
		fi
		if has_version dev-lang/spidermonkey[threadsafe] ; then
			JAVASCRIPT_ENGINE_CFLAGS="${JAVASCRIPT_ENGINE_CFLAGS} -DJS_THREADSAFE $(pkg-config --cflags nspr)"
			JAVASCRIPT_ENGINE_LIBS="$(pkg-config --libs nspr) ${JAVASCRIPT_ENGINE_LIBS}"
		fi
		export JAVASCRIPT_ENGINE_CFLAGS
		export JAVASCRIPT_ENGINE_LIBS
	fi
	if ! use expat; then
		myconf="${myconf} --without-expat"
	fi
	econf	${myconf} \
		$(use_enable curl libcurl) \
		$(use_with glew) \
		$(use_enable debug) $(use_enable debug thread_colorized) \
		$(use_enable libeai) \
		$(use_enable java) \
		$(use_enable nsplugin plugin) \
		$(use_enable osc) \
		$(use_enable static-libs static) \
		$(use_enable sox sound)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use java; then
		insinto /usr/share/${PN}/lib
		doins src/java/java.policy
		java-pkg_regjar src/java/vrml.jar
		# install vrml.jar as a JRE extension
		dodir /usr/java/packages/lib/ext
		dosym /usr/share/${PN}/lib/vrml.jar /usr/java/packages/lib/ext/vrml.jar
		elog "Because vrml.jar requires access to sockets, you will need to incorporate the"
		elog "contents of /usr/share/${PN}/lib/java.policy into your system or user's default"
		elog "java policy:"
		elog "	cat /usr/share/${PN}/lib/java.policy >>~/.java.policy"
	fi

	# remove unneeded .la files (as per Flameeyes' rant)
	cd "${D}"
	rm "usr/$(get_libdir)"/*.la "usr/$(get_libdir)/${PLUGINS_DIR}"/*.la
}

pkg_postinst() {
	elog "By default, FreeWRL expects to find the 'firefox' binary in your include"
	elog "path.  If you do not have firefox installed or you wish to use a different"
	elog "web browser to open links that are within VRML / X3D files, please be sure to"
	elog "specify the command via your BROWSER environment variable."
}
