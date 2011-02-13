# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tables/scim-tables-0.5.8-r1.ebuild,v 1.9 2011/02/13 18:09:08 armin76 Exp $

inherit autotools base eutils

DESCRIPTION="Smart Common Input Method (SCIM) Generic Table Input Method Server"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="nls"
LANGS="am ar bn gu hi ja kn ko ml ne pa ru ta te th uk vi zh"
for i in ${LANGS} ; do
	IUSE="${IUSE} linguas_${i}"
done

RDEPEND=">=app-i18n/scim-1.4.7-r2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}/${P}+gcc-4.3.patch" )

pkg_setup() {
	elog "Not all languages are going to be compiled."
	elog "Please set LINGUAS to your preferred language(s)."
	elog "Supported LINGUAS values are:"
	elog "${LANGS}"
}

src_unpack() {
	base_src_unpack

	strip-linguas ${LANGS}
	local use_languages="additional ${LINGUAS}"
	elog "Languages being compiled are: ${use_languages}"

	cd "${S}"
	sed -i -e "/^SUBDIRS/s/.*/SUBDIRS = ${use_languages}/g" \
			tables/Makefile.{am,in} || die "sed ${m} failed"

	AT_NO_RECURSIVE=yes AT_M4DIR=${S}/m4 eautoreconf
}

src_compile() {
	econf \
		--disable-skim-support \
		$(use_enable nls) \
		--disable-static \
		--disable-dependency-tracking \
		--without-arts || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog AUTHORS
}
