# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.6.ebuild,v 1.2 2003/02/13 11:34:56 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ldaptor" 
SRC_URI="http://twistedmatrix.com/users/tv/ldaptor/${PN}_${PV}.tar.gz"
HOMEPAGE="http://twistedmatrix.com/users/tv/ldaptor/"
LICENSE="LGPL-2.1"
SLOT="0"
DEPEND=">=dev-python/twisted-1.0.1-r1"
RDEPEND="$DEPEND"
KEYWORDS="~x86 ~alpha ~sparc"
IUSE=""

#inherit distutils

src_compile() {
	python setup-ldaptor-utils.py build || \
	    die "compilation of ldaptor-utils failed"
	python setup-ldaptor-webui.py build || \
	    die "compilation of ldaptor-webui failed"
	python setup-python-ldaptor.py build || \
	    die "compilation of python-ldaptor failed"
}
src_install() {
	python setup-ldaptor-utils.py install --root=${D} || die
	python setup-ldaptor-webui.py install --root=${D} || die
	python setup-python-ldaptor.py install --root=${D} || die
	
	dodoc README TODO rfc2251-status.txt

	# install examples
	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	# install tests
	dodir /usr/share/doc/${PF}/tests
	insinto /usr/share/doc/${PF}/tests
       	doins tests/*
}

