# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.0.2-r2.ebuild,v 1.7 2007/02/18 10:10:11 nixnut Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A powerful, high performance and quality Code Generation Library, It is used to extend Java classes and implements interfaces at runtime."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="amd64 ppc x86"
COMMON_DEP="
	source? ( app-arch/zip )
	=dev-java/asm-1.4.3*
	=dev-java/aspectwerkz-2*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	${COMMON_DEP}"
IUSE="doc source"

S=${WORKDIR}

src_unpack() {
	jar xf ${DISTDIR}/${A} || die "failed to unpack"

	epatch ${FILESDIR}/${P}-asm-1.4.3.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-1.4
	java-pkg_jar-from aspectwerkz-2
	java-pkg_jar-from ant-core ant.jar
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar dist/${PN}-${PV}.jar ${PN}.jar
	java-pkg_newjar dist/${PN}-full-${PV}.jar ${PN}-full.jar

	dodoc NOTICE README
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/proxy/net
}
