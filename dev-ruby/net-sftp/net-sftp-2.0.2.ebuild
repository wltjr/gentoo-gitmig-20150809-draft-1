# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-sftp/net-sftp-2.0.2.ebuild,v 1.2 2009/03/04 23:42:50 flameeyes Exp $

inherit gems

DESCRIPTION="SFTP in pure Ruby"
HOMEPAGE="http://net-ssh.rubyforge.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-ruby/net-ssh-2.0.9"
DEPEND="${RDEPEND}"
