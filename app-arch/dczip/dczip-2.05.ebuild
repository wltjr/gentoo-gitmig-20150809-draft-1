# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dczip/dczip-2.05.ebuild,v 1.7 2005/12/12 19:53:32 metalgod Exp $

DESCRIPTION="dcZip is an archiving program for managing various compression file formats"
HOMEPAGE="http://www.davidcampaign.net/dczip.html"
SRC_URI="http://www.davidcampaign.net/files/${PN}.jar"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~ppc-macos ~sparc x86"
IUSE=""
DEPEND="virtual/x11
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_install() {
	insinto /opt/${PN}/lib
	doins ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -jar lib/${PN}.jar '$*' >> ${PN}

	into /opt
	dobin ${PN}
}
