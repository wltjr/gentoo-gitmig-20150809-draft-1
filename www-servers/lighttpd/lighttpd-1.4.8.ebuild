# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.4.8.ebuild,v 1.3 2006/02/13 15:24:48 mcummings Exp $

inherit eutils depend.php

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"
SRC_URI="http://www.lighttpd.net/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="bzip2 doc fam fastcgi gdbm ipv6 ldap lua minimal memcache mysql pcre php rrdtool ssl test webdav xattr"

RDEPEND=">=sys-libs/zlib-1.1
	bzip2?    ( app-arch/bzip2 )
	fam?      ( virtual/fam )
	gdbm?     ( sys-libs/gdbm )
	ldap?     ( >=net-nds/openldap-2.1.26 )
	lua?      ( dev-lang/lua )
	memcache? ( dev-libs/libmemcache )
	mysql?    ( >=dev-db/mysql-4.0.0 )
	pcre?     ( >=dev-libs/libpcre-3.1 )
	php?      (
		virtual/httpd-php
		!net-www/spawn-fcgi
	)
	rrdtool? ( net-analyzer/rrdtool )
	ssl?    ( >=dev-libs/openssl-0.9.7 )
	webdav? (
		dev-libs/libxml2
		>=dev-db/sqlite-3
	)
	xattr?  ( sys-apps/attr )"

DEPEND="${RDEPEND}
	doc?  ( dev-python/docutils )
	test? (
		virtual/perl-Test-Harness
		dev-libs/fcgi
	)"

# update certain parts of lighttpd.conf based on conditionals
update_config() {
	local config="/etc/lighttpd/lighttpd.conf"

	# enable php/mod_fastcgi settings
	use php && \
		dosed 's|#.*\(include.*fastcgi.*$\)|\1|' ${config}

	# enable stat() caching
	use fam && \
		dosed 's|#\(.*stat-cache.*$\)|\1|' ${config}
}

# remove non-essential stuff (for USE=minimal)
remove_non_essential() {
	local libdir="${D}/usr/$(get_libdir)/${PN}"

	# text docs
	use doc || rm -fr ${D}/usr/share/doc/${PF}/txt

	# non-essential modules
	rm -f \
		${libdir}/mod_{compress,evhost,expire,proxy,scgi,secdownload,simple_vhost,status,setenv,trigger*,usertrack}.*

	# allow users to keep some based on USE flags
	use pcre    || rm -f ${libdir}/mod_{ssi,re{direct,write}}.*
	use webdav  || rm -f ${libdir}/mod_webdav.*
	use mysql   || rm -f ${libdir}/mod_mysql_vhost.*
	use lua     || rm -f ${libdir}/mod_cml.*
	use rrdtool || rm -f ${libdir}/mod_rrdtool.*

	if ! use fastcgi ; then
		rm -f ${libdir}/mod_fastcgi.* ${D}/usr/bin/spawn-fcgi \
			${D}/usr/share/man/man1/spawn-fcgi.*
	fi
}

pkg_setup() {
	if ! use pcre ; then
		ewarn "It is highly recommended that you build ${PN}"
		ewarn "with perl regular expressions support via USE=pcre."
		ewarn "Otherwise you lose support for some core options such"
		ewarn "as conditionals and modules such as mod_re{write,direct}"
		ewarn "and mod_ssi."
		ebeep 5
	fi

	use php && require_php_with_use cgi
}

src_unpack() {
	unpack ${A}
	cd ${S}

#    EPATCH_SUFFIX="diff" epatch ${FILESDIR}/${PV}

#    einfo "Regenerating autoconf/automake files"
#    libtoolize --copy --force || die "libtoolize failed"
#    aclocal || die "aclocal failed"
#    autoheader || die "autoheader failed"
#    automake --add-missing --copy || die "automake failed"
#    autoconf || die "autoconf failed"

	# dev-python/docutils installs rst2html.py not rst2html
	sed -i -e 's|\(rst2html\)|\1.py|g' doc/Makefile.in || \
		die "sed doc/Makefile.in failed"
}

src_compile() {
	econf --libdir=/usr/$(get_libdir)/${PN} \
		--enable-lfs \
		$(use_enable ipv6) \
		$(use_with bzip2) \
		$(use_with fam) \
		$(use_with gdbm) \
		$(use_with lua) \
		$(use_with ldap) \
		$(use_with memcache) \
		$(use_with mysql) \
		$(use_with pcre) \
		$(use_with ssl openssl) \
		$(use_with webdav webdav-props) \
		$(use_with xattr attr) \
		|| die "econf failed"

	emake || die "emake failed"

	if use doc ; then
		einfo "Building HTML documentation"
		cd doc
		emake html || die "failed to build HTML documentation"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# init script stuff
	newinitd ${FILESDIR}/lighttpd.initd lighttpd || die

	if use php || use fastcgi ; then
		newinitd ${FILESDIR}/spawn-fcgi.initd spawn-fcgi || die
		newconfd ${FILESDIR}/spawn-fcgi.confd spawn-fcgi || die
	fi

	# configs
	insinto /etc/lighttpd
	doins ${FILESDIR}/conf/*.conf

	# update lighttpd.conf directives based on conditionals
	update_config

	# docs
	dodoc AUTHORS README COPYING INSTALL NEWS ChangeLog doc/*.sh
	newdoc doc/lighttpd.conf lighttpd.conf.distrib

	use doc && dohtml -r doc/*

	docinto txt
	dodoc doc/*.txt

	# logrotate
	insinto /etc/logrotate.d
	newins ${FILESDIR}/lighttpd.logrotate lighttpd || die

	keepdir /var/l{ib,og}/lighttpd /var/www/localhost/htdocs

	use minimal && remove_non_essential
}

pkg_preinst() {
	enewgroup lighttpd
	enewuser lighttpd -1 -1 /var/www/localhost/htdocs lighttpd
	fowners lighttpd:lighttpd /var/l{ib,og}/lighttpd
}

pkg_postinst () {
	echo
	if [[ -f ${ROOT}etc/conf.d/spawn-fcgi.conf ]] ; then
		einfo "spawn-fcgi is now included with lighttpd"
		einfo "spawn-fcgi's init script configuration is now located"
		einfo "at /etc/conf.d/spawn-fcgi."
		echo
	fi

	if [[ -f ${ROOT}etc/lighttpd.conf ]] ; then
		ewarn "As of lighttpd-1.4.1, Gentoo has a customized configuration,"
		ewarn "which is now located in /etc/lighttpd.  Please migrate your"
		ewarn "existing configuration."
		ebeep 5
	fi
	echo
}
