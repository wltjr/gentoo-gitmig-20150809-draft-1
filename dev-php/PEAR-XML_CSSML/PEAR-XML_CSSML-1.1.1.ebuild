# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_CSSML/PEAR-XML_CSSML-1.1.1.ebuild,v 1.3 2005/10/16 06:24:52 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="A template system for generating cascading style sheets (CSS)"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

pkg_postinst () {
	ewarn "The XML_CSSML PEAR package is unmaintained and requires"
	ewarn "PHP 4 built with the DOMXML extension (USE=xml2)."
}

need_php4
