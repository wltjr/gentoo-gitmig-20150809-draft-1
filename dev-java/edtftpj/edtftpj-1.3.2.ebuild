# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/edtftpj/edtftpj-1.3.2.ebuild,v 1.1 2004/05/14 17:14:36 zx Exp $

inherit java-pkg

DESCRIPTION="FTP client library written in Java"
SRC_URI="http://www.enterprisedt.com/products/edtftpj/download/${P}.tar.gz"
HOMEPAGE="http://www.enterprisedt.com"
LICENSE="LGPL-2"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="jikes doc"
DEPEND="virtual/jdk
	>=dev-java/ant-1.5"
RDEPEND="virtual/jdk"
SLOT="0"

src_compile() {
	cd ${S}/src
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	cd ${S}
	use doc && dohtml -r build/doc/api
	dodoc doc/*.TXT
	insinto /usr/share/doc/${PF}
	doins doc/*.pdf

	mv ${S}/build/${P}.jar ${S}/build/${PN}.jar
	java-pkg_dojar build/${PN}.jar
}
