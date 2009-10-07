# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.1.26.ebuild,v 1.1 2009/10/07 14:39:51 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
SRC_URI="ftp://xmlsoft.org/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="crypt debug python"

RDEPEND=">=dev-libs/libxml2-2.6.27
	crypt?  ( >=dev-libs/libgcrypt-1.1.42 )
	python? ( >=dev-lang/python-2.5 )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/libxslt.m4-${P}.patch \
		"${FILESDIR}"/${PN}-1.1.23-parallel-install.patch
	eautoreconf
	epunt_cxx
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--with-html-dir=/usr/share/doc/${PF} \
		--with-html-subdir=html \
		$(use_with crypt crypto) \
		$(use_with python) \
		$(use_with debug) \
		$(use_with debug mem-debug)

}

src_install() {
	emake DESTDIR="${D}" install || die
	mv -vf "${D}"/usr/share/doc/${PN}-python-${PV} \
		"${D}"/usr/share/doc/${PF}/python
	dodoc AUTHORS ChangeLog FEATURES NEWS README TODO || die
}
