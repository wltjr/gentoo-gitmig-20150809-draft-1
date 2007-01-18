# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.4.3-r2.ebuild,v 1.9 2007/01/18 03:53:46 beandog Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="mirror://apache/jakarta/lucene/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="amd64 ~ia64 ppc x86"
IUSE="doc test source"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/ant-core-1.5
	test? ( dev-java/junit dev-java/ant-tasks )"
RDEPEND=">=virtual/jdk-1.2"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar
	use test && java-pkg_jar-from junit
}

src_compile() {
	eant jar-core $(use_doc javadocs)
}

src_test() {
	eant test
}

src_install() {
	dodoc CHANGES.txt README.txt
	java-pkg_newjar build/lucene-1.5-rc1-dev.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/* build/docs/*
	use source && java-pkg_dosrc src/java/org
}
