# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ipe/ipe-7.1.2.ebuild,v 1.2 2012/05/10 18:27:23 mr_bones_ Exp $

EAPI=4
inherit eutils toolchain-funcs qt4-r2

DESCRIPTION="Drawing editor for creating figures in PDF or PS formats"
HOMEPAGE="http://ipe7.sourceforge.net/"
SRC_URI="mirror://sourceforge/ipe7/${PN}/7.1.0/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/texlive-core
	dev-lang/lua
	media-libs/freetype:2
	x11-libs/cairo
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${P}/src"

search_urw_fonts() {
	# colon-separated list of paths
	local texmfdist="$(kpsewhich -var-value=TEXMFDIST)"
	# according to TeX directory structure
	local urwdir=fonts/type1/urw
	# add colon as field separator
	local IFS="${IFS}:" dir
	for dir in ${texmfdist}; do
		if [[ -d ${dir}/${urwdir} ]]; then
			URWFONTDIR="${dir}/${urwdir}"
			return 0
		fi
	done
	return 1
}

pkg_setup() {
	if search_urw_fonts; then
		einfo "URW fonts found in ${URWFONTDIR}"
	else
		ewarn "Could not find directory containing URW fonts"
		ewarn "Ipe will not function properly without them."
	fi
}

src_prepare() {
	sed -i \
		-e 's/fpic/fPIC/' \
		-e 's/moc-qt4/moc/' \
		-e "s:\$(IPEPREFIX)/lib:\$(IPEPREFIX)/$(get_libdir):g" \
		config.mak || die
	sed -i -e 's/install -s/install/' common.mak || die

}

src_compile() {
	emake \
		CXX=$(tc-getCXX) \
		IPEPREFIX="${EPREFIX}/usr" \
		IPEDOCDIR="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	emake install \
		IPEPREFIX="${EPREFIX}/usr" \
		IPEDOCDIR="${EPREFIX}/usr/share/doc/${PF}/html" \
		INSTALL_ROOT="${ED}"
	dodoc ../{news,readme}.txt
	doicon ipe/icons/ipe.png
	make_desktop_entry ipe Ipe ipe
}
