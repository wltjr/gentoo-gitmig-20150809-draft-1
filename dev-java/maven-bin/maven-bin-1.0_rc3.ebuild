# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven-bin/maven-bin-1.0_rc3.ebuild,v 1.5 2005/09/02 12:25:02 flameeyes Exp $

DESCRIPTION="Project Management and Comprehension Tool for Java"
SRC_URI="mirror://apache/maven/binaries/${PN/-bin}-${PV/_/-}.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-2.0"
SLOT="1.0"
KEYWORDS="x86 ppc amd64"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE=""

S="${WORKDIR}/${PN/-bin}-${PV/_/-}"

src_compile() { :; }

src_install() {
	dodir /usr/share/maven
	dodir /usr/lib/java
	exeinto /usr/bin
	doexe ${S}/bin/maven
	insinto /etc/env.d
	doins ${FILESDIR}/25maven
	cp -Rp * ${D}/usr/share/maven
}
