# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-platform-bin/eclipse-platform-bin-2.0.2.ebuild,v 1.2 2003/02/13 11:51:37 vapier Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.0.2-200211071448/eclipse-platform-2.0.2-linux-gtk.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="x86 sparc "

DEPEND=">=virtual/jdk-1.2
	=x11-libs/gtk+-2*"

src_install () {
	dodir /opt/eclipse

	cp -dpR features install.ini libXm* eclipse icon.xpm plugins startup.jar \
		${D}/opt/eclipse/

	dohtml cpl-v10.html notice.html readme/*

	dodir /etc/env.d
	echo "LDPATH=/opt/eclipse" > ${D}/etc/env.d/20eclipse
}
