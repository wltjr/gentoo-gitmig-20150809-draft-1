# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-es/man-pages-es-1.55.ebuild,v 1.1 2005/09/02 04:29:19 vapier Exp $

manpagesextra=${PN}-extra-0.8a
S2=${WORKDIR}/${manpagesextra}

DESCRIPTION="A somewhat comprehensive collection of Linux spanish man page translations"
HOMEPAGE="http://ditec.um.es/~piernas/manpages-es/index.html"
SRC_URI="http://ditec.um.es/~piernas/manpages-es/${P}.tar.bz2
	http://ditec.um.es/~piernas/manpages-es/${manpagesextra}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="unicode"

RDEPEND="sys-apps/man"

src_compile() { :; }

src_install() {
	local d f toencoding

	dodoc man?/{LEAME,README}

	dodir /usr/share/man/es/man{1,2,3,4,5,6,7,8}

	useq unicode && toencoding=utf-8 || toencoding=iso8859-1

	# This is needed because manpages-es has broken encodings upstream
	for d in "${S}" "${S2}" ; do
		cd "${d}"
		file -i man?/* | while read f ; do
			iconv -f ${f##*=} \
				-t ${toencoding} ${d}/${f%%:*} \
				-o ${D}/usr/share/man/es/${f%%:*}
		done
	done
}
