# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jing/jing-20030619-r1.ebuild,v 1.4 2005/01/17 18:31:08 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI="http://www.thaiopensource.com/download/jing-${PV}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.3
	=dev-java/saxon-bin-8*
	=dev-java/xerces-1.3.1*
	dev-java/iso-relax"

src_unpack() {
	unpack ${A}

	cd ${S}
	mkdir src/
	unzip -qq -d src/ src.zip
	cd src/
	epatch ${FILESDIR}/build-patch.diff

	cd ../bin/
	rm -f *.jar
	java-pkg_jar-from iso-relax
	java-pkg_jar-from xerces-1.3 xerces.jar
	java-pkg_jar-from saxon-bin saxon8.jar saxon.jar

	cd ..
	cp ${FILESDIR}/build.xml .
	cp ${FILESDIR}/manifest.mf .
}

src_compile() {
	antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar bin/jing.jar
	cat >jing <<'EOF'
#!/bin/sh
exec `java-config --java` -classpath `java-config -p xerces-1.3,saxon-bin,iso-relax` -jar `java-config -p jing` "$@"
EOF
	dobin jing
	use doc && java-pkg_dohtml -r doc/* readme.html
}
