# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ppcre/cl-ppcre-1.0.0.ebuild,v 1.1 2004/12/22 17:48:57 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-PPCRE is a portable regular expression library for Common Lisp."
HOMEPAGE="http://weitz.de/cl-ppcre/
	http://www.cliki.net/cl-ppcre"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"
SLOT="0"

CLPACKAGE=cl-ppcre

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CHANGELOG README doc/benchmarks.2002-12-22.txt
	dohtml doc/index.html
}
