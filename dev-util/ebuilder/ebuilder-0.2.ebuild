# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Zach Forrest <zach@disinformation.ca>
# $Header: /var/cvsroot/gentoo-x86/dev-util/ebuilder/ebuilder-0.2.ebuild,v 1.2 2002/04/27 23:08:36 bangert Exp $

# This ebuild was generated by Ebuilder v0.2.

S="${WORKDIR}/${P}"
DESCRIPTION="Package Builder for Gentoo Linux"
SRC_URI="http://www.disinformation.ca/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.disinformation.ca/gentoo"
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {
	dodir /usr/share/ebuilder
	dodir /usr/share/ebuilder/templates

	insinto /usr/share/ebuilder/templates
	doins templates/beginner.ebuild
	doins templates/expert.ebuild

	dosbin ebuilder

	# Install documentation.
	dodoc AUTHORS COPYING NEWS README TODO
}
