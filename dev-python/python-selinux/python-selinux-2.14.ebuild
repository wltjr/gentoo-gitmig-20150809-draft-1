# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.14.ebuild,v 1.4 2004/06/25 01:46:35 agriffis Exp $

inherit python
python_version

DESCRIPTION="Python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="dev-lang/python
	sys-libs/libselinux"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir -p ${S}
	bzcat ${FILESDIR}/${P}.c.bz2 > ${S}/selinux.c
}

src_compile() {
	cd ${S}
	einfo "Compiling selinux.so for python ${PYVER}"
	gcc -fPIC -shared -o selinux.so -I /usr/include/python${PYVER}/ selinux.c -lselinux || die
}

src_install() {
	insinto /usr/lib/python${PYVER}/site-packages
	doins selinux.so
}
