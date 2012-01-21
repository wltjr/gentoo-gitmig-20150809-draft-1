# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SDL/SDL-2.536.ebuild,v 1.2 2012/01/21 21:07:51 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=FROGGS
inherit perl-module

DESCRIPTION="Simple DirectMedia Layer (SDL) bindings for perl"
HOMEPAGE="http://sdl.perl.org/"

LICENSE="GPL-2 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Alien-SDL
	dev-perl/Capture-Tiny
	dev-perl/File-ShareDir
	dev-perl/Test-Most
	dev-perl/Tie-Simple
	media-libs/libpng:0
	media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-pango
	media-libs/sdl-ttf
	media-libs/smpeg
	media-libs/tiff:0
	virtual/glu
	virtual/jpeg
	virtual/opengl
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build
	virtual/perl-Scalar-List-Utils
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

pkg_setup() {
	# Only enable this if you are confirming a bug in this module. The testsrequire
	# access to your /dev/{snd,sound} devices.
	#SRC_TEST="do"
	mydoc="CHANGELOG README TODO"
	perl-module_pkg_setup
}

