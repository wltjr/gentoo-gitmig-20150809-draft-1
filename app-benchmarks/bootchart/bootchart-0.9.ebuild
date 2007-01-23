# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bootchart/bootchart-0.9.ebuild,v 1.3 2007/01/23 15:45:41 genone Exp $

inherit eutils java-pkg

DESCRIPTION="Performance analysis and visualization of the system boot process"
HOMEPAGE="http://www.bootchart.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

DEPEND="
	java? (
		>=virtual/jdk-1.3
		>=dev-java/ant-1.4
		jikes? ( dev-java/jikes )
		dev-java/commons-cli
	)
"

RDEPEND="
	java? (
		>=virtual/jdk-1.3
		dev-java/commons-cli
	)
	acct? ( sys-process/acct )
"

LICENSE="GPL-2"
SLOT="0"
IUSE="acct debug doc java jikes"
KEYWORDS="~amd64 ~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-0.9-gentoo.patch"

	# delete the included commons-cli and use gentoo's instead
	rm -rf lib/org/apache/commons/cli lib/org/apache/commons/lang

	if use java ; then
		sed -i -e 's,AUTO_RENDER="no",AUTO_RENDER="yes",g' \
			script/bootchartd.conf
	fi

	if use acct ; then
		sed -i -e 's,PROCESS_ACCOUNTING="no",PROCESS_ACCOUNTING="yes",g' \
			script/bootchartd.conf
	fi
}

src_compile() {
	if use java ; then
		local antflags="jar "
		use doc && antflags="${antflags} javadoc"

		antflags="${antflags} -Dcompiler.nowarn=true"
		use debug || antflags="${antflags} -Dbuild.debug=false"
		use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
		CLASSPATH=$(java-config -p commons-cli-1) ant ${antflags} \
			|| die "compile failed"
	fi
}

src_install() {
	dodoc README README.logger ChangeLog COPYING TODO

	insinto /lib/rcscripts/addons
	doins "${FILESDIR}/profiling-functions.sh"

	into /
	newsbin script/bootchartd bootchartd
	into /usr

	# This dir is normally empty, but is used to bind to the
	# temporary dir bootchart normally makes. We do this so
	# that our profiling script can write to a fixed location.
	keepdir /lib/bootchart

	insinto /etc
	doins script/bootchartd.conf

	if use java ; then
		java-pkg_dojar "${PN}.jar"
		use doc && java-pkg_dohtml -r build/docs/api
		newbin "${FILESDIR}/bootchart" bootchart
	fi
}

pkg_postinst() {
	elog "To generate the chart, set RC_USE_BOOTCHART=\"yes\""
	elog "in /etc/conf.d/rc and reboot"
	elog

	if use java; then
		elog "The chart will be saved as /var/log/bootchart.png"
	else
		elog "Post the file /var/log/bootchart.tgz here:"
		elog "   http://www.bootchart.org/download.html"
		elog "to render the chart"
	fi

	elog
	elog "For best results: "
	elog "  Enable BSD process accounting v3 in the kernel"
	elog "    This will produce more accurate process trees"
	elog "  Set AUTO_RENDER_FORMAT to svg in /etc/bootchartd.conf"
	elog "    and view /var/log/bootchart.svgz with batik or"
	elog "    Adobe SVG viewer. This will give you additional"
	elog "    information about the processes in tooltips"
}
