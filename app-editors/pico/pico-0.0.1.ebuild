# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/pico/pico-0.0.1.ebuild,v 1.9 2004/05/30 08:26:10 robbat2 Exp $

HOMEPAGE="http://www.washington.edu/pine"
DESCRIPTION="Pico text editor"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/glibc"

PROVIDE="virtual/editor"

pkg_setup () {
	einfo "There is no real Pico here."
	einfo ""
	einfo 'Pico is part of mail-client/pine. Try "emerge app-editors/nano"'
	einfo "for a good Pico clone (it should be installed by default)."
	einfo ""
	einfo "If you really want to use the original Pico, you may want"
	einfo 'to try "emerge mail-client/pine" instead.'

	die "Pico is in mail-client/pine"
}

