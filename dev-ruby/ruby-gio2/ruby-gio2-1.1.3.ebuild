# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gio2/ruby-gio2-1.1.3.ebuild,v 1.5 2012/09/28 15:37:29 ssuominen Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby binding of GooCanvas"
KEYWORDS="amd64 ppc x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
