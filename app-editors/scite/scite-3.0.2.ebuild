# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scite/scite-3.0.2.ebuild,v 1.1 2012/01/27 22:19:03 nelchael Exp $

EAPI="4"

inherit toolchain-funcs eutils

MY_PV=${PV//./}
DESCRIPTION="A very powerful editor for programmers"
HOMEPAGE="http://www.scintilla.org/SciTE.html"
SRC_URI="mirror://sourceforge/scintilla/${PN}${MY_PV}.tgz"

LICENSE="Scintilla"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="lua"

RDEPEND="x11-libs/gtk+:2
	lua? ( >=dev-lang/lua-5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}/gtk"

src_prepare() {
	cd "${WORKDIR}/scintilla/gtk"
	sed -i makefile \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e "s#-Os##" \
		|| die "error patching makefile"

	cd "${WORKDIR}/scite/gtk"
	sed -i makefile \
		-e "s#-rdynamic#-rdynamic ${LDFLAGS}#" \
		|| die "error patching makefile"

	cd "${S}"
	sed -i makefile \
		-e 's#usr/local#usr#g' \
		-e 's#/gnome/apps/Applications#/applications#' \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e 's#${D}##' \
		-e 's#-g root#-g 0#' \
		-e "s#-Os##" \
		|| die "error patching makefile"
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}-3.0.1-no-lua.patch"
}

src_compile() {
	emake -C ../../scintilla/gtk
	if use lua; then
		emake
	else
		emake NO_LUA=1
	fi
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/{pixmaps,applications}

	emake prefix="${ED}/usr" install

	# we have to keep this because otherwise it'll break upgrading
	mv "${ED}/usr/bin/SciTE" "${ED}/usr/bin/scite" || die
	dosym /usr/bin/scite /usr/bin/SciTE

	# replace .desktop file with our own working version
	rm -f "${ED}/usr/share/applications/SciTE.desktop"
	insinto /usr/share/applications
	doins "${FILESDIR}/scite.desktop"

	doman ../doc/scite.1
	dodoc ../README
}
