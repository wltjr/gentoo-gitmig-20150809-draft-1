# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jlex/jlex-1.2.6.ebuild,v 1.10 2005/07/09 16:04:58 axxo Exp $

inherit java-pkg

DESCRIPTION="JLex: a lexical analyzer generator for Java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/JLex/"
KEYWORDS="x86 ppc sparc amd64"
LICENSE="jlex"
SLOT="0"
DEPEND=">=virtual/jdk-1.2
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.2"
IUSE="doc jikes"

src_compile() {
	use jikes && jikes -q Main.java || javac -nowarn Main.java
}

src_install() {
	dodoc README Bugs
	use doc && dohtml manual.html
	use doc && dodoc sample.lex
	mkdir JLex && mv *.class JLex/
	jar cf jlex.jar JLex/ || die "failed to jar"
	java-pkg_dojar jlex.jar
}
