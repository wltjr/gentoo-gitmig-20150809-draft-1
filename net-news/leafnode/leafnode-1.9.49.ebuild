# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/leafnode/leafnode-1.9.49.ebuild,v 1.7 2004/06/28 22:45:31 swegener Exp $

MY_P=${P}.rel

DESCRIPTION="A USENET software package designed for small sites"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://leafnode.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="ipv6"

DEPEND=">=dev-libs/libpcre-3.9"
RDEPEND="${DEPEND}
	virtual/inetd"

S=${WORKDIR}/${MY_P}

src_compile() {
	use ipv6 && myconf="--with-ipv6"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/leafnode \
		--localstatedir=/var \
		${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# remove the spool dirs -- put them back in during pkg_postinst, so that
	# they don't get removed during an unmerge or upgrade
	rm -rf ${D}/var/spool

	# add .keep file to /var/lock/news to avoid ebuild to ignore the empty dir
	keepdir /var/lock/news

	insinto /etc/xinetd.d
	newins ${FILESDIR}/leafnode.xinetd leafnode-nntp

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/fetchnews.cron
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/texpire.cron

	dodoc \
		COPYING* CREDITS ChangeLog FAQ.txt FAQ.pdf INSTALL NEWS \
		TODO README.FIRST README-daemontools UNINSTALL-daemontools \
		README README-MAINTAINER README-FQDN PCRE_README
	dohtml FAQ.html FAQ.xml README-FQDN.html
}

pkg_postinst() {
	mkdir -p ${ROOT}/var/spool/news/{leaf.node,failed.postings,interesting.groups,out.going}
	mkdir -p ${ROOT}/var/spool/news/message.id/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
	chown -R news:news ${ROOT}/var/spool/news

	mkdir -p ${ROOT}/var/lib/news
	chown -R news:news ${ROOT}/var/lib/news

	zcat ${ROOT}/usr/share/doc/${PF}/README.FIRST.gz | while read line ;
	do
		einfo $line
	done
}
