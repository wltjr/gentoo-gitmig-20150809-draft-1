# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/ssmtp/ssmtp-2.38.14-r1.ebuild,v 1.3 2004/07/01 19:54:39 eradicator Exp $

DESCRIPTION="Extremely simple MTA to get mail off the system to a Mailhub"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/system/mail/mta/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND="virtual/libc"
RDEPEND="!virtual/mta
	net-mail/mailbase"
PROVIDE="virtual/mta"

src_compile() {
	make clean || die
	make ${MAKEOPTS} || die
}

src_install() {
	dodir /usr/bin /usr/sbin /usr/lib
	dosbin ssmtp
	chmod 755 ${D}/usr/sbin/ssmtp
	dosym /usr/sbin/ssmtp /usr/bin/mailq
	dosym /usr/sbin/ssmtp /usr/bin/newaliases
	# Removed symlink due to conflict with mailx
	# See bug #7448
	#dosym /usr/sbin/ssmtp /usr/bin/mail
	dosym /usr/sbin/ssmtp /usr/sbin/sendmail
	dosym /usr/sbin/ssmtp /usr/lib/sendmail
	doman ssmtp.8
	dosym /usr/share/man/man8/ssmtp.8 /usr/share/man/man8/sendmail.8
	dodoc CHANGELOG INSTALL MANIFEST README
	newdoc ssmtp.lsm DESC
	insinto /etc/ssmtp
	doins ssmtp.conf revaliases
}

pkg_config() {
	local conffile="/etc/ssmtp/ssmtp.conf"
	local hostname=`hostname -f`
	local domainame=`hostname -d`
	mv ${conffile} ${conffile}.orig
	sed -e "s:rewriteDomain\=:rewriteDomain\=${domainame}:g" \
		-e "s:_HOSTNAME_:${hostname}:" \
		-e "s:\=mail:\=mail.${domainame}:g" \
		${conffile}.orig > ${conffile}

}
