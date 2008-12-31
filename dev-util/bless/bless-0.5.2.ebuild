# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.5.2.ebuild,v 1.3 2008/12/31 03:24:36 mr_bones_ Exp $

inherit autotools eutils gnome2 mono

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-1.1.14
		>=dev-dotnet/gtk-sharp-2.8
		|| ( >=dev-dotnet/gtk-sharp-2.12.6 >=dev-dotnet/glade-sharp-2.8 )"
DEPEND="${RDEPEND}
		  app-text/scrollkeeper
		>=sys-devel/gettext-0.15
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	if has_version '>=dev-dotnet/gtk-sharp-2.12.6'
	then
		if ! built_with_use --missing false 'dev-dotnet/gtk-sharp' 'glade'
		then
			eerror "Please rebuild >=dev-dotnet/gtk-sharp-2.12.6 with USE='glade'"
			die "Please rebuild >=dev-dotnet/gtk-sharp-2.12.6 with USE='glade'"
		fi
	fi

	G2CONF="${G2CONF} --enable-unix-specific $(use_enable debug)"

	# Stolen from enlightenment.eclass
	cp $(type -p gettextize) "${T}/" || die "Could not copy gettextize"
	sed -i -e 's:read dummy < /dev/tty::' "${T}/gettextize"
}

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}/${P}-mono-2.patch"

	einfo "Running gettextize -f --no-changelog..."
	( "${T}/gettextize" -f --no-changelog > /dev/null ) || die "gettexize failed"
	eautoreconf
}
