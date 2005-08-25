# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-0.12.0.ebuild,v 1.7 2005/08/25 20:09:44 agriffis Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=x11-libs/gtk+-2.0.0"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}"
