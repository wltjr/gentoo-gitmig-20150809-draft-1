# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-6.3.6.ebuild,v 1.1 2007/01/06 19:32:56 ticho Exp $

inherit eutils

FCONF_P="fetchmailconf-1.43.2"

DESCRIPTION="the legendary remote-mail retrieval and forwarding utility"
HOMEPAGE="http://fetchmail.berlios.de"
SRC_URI="http://download2.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86
~x86-fbsd"
IUSE="ssl nls ipv6 kerberos krb4 hesiod"

DEPEND="hesiod? ( net-dns/hesiod )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( app-crypt/mit-krb5 )
	nls? ( sys-devel/gettext )
	elibc_FreeBSD? ( sys-libs/com_err )"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd \${S} failed"

	# this patch fixes bug #34788 (ticho@gentoo.org 2004-09-03)
	epatch ${FILESDIR}/${PN}-6.2.5-broken-headers.patch || die
}

src_compile() {
	econf  --disable-dependency-tracking \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		$(use_enable nls) \
		$(use_enable ipv6 inet6) \
		$(use_with kerberos gssapi) $(use_with kerberos kerberos5) \
		$(use_with krb4 kerberos) \
		$(use_with ssl) \
		$(use_with hesiod) \
		${myconf} || die "Configuration failed."
	# wont compile reliably on smp (mkennedy@gentoo.org 2003-11-12)
	emake || die "Compilation failed."
}

src_install() {
	emake DESTDIR="${D}" install || die

	dohtml *.html

	dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README \
		README.NTLM README.SSL TODO COPYING

	newinitd ${FILESDIR}/fetchmail fetchmail
	newconfd ${FILESDIR}/conf.d-fetchmail fetchmail

	docinto contrib
	local f
	for f in contrib/*
	do
		[ -f "${f}" ] && dodoc "${f}"
	done
}

pkg_postinst() {
	if ! python -c "import Tkinter" >/dev/null 2>&1
	then
		einfo
		einfo "You will not be able to use fetchmailconf(1), because you"
		einfo "don't seem to have Python with tkinter support."
		einfo
		einfo "If you want to be able to use fetchmailconf(1), do the following:"
		einfo "  1.  Add 'tk' to the USE variable in /etc/make.conf."
		einfo "  2.  (Re-)merge Python."
		einfo
	fi

	einfo "Please see /etc/conf.d/fetchmail if you want to adjust"
	einfo "the polling delay used by the fetchmail init script."
}
