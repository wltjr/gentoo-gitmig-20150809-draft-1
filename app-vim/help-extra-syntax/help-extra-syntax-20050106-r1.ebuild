# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/help-extra-syntax/help-extra-syntax-20050106-r1.ebuild,v 1.2 2006/08/20 23:44:02 malc Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: extra syntax highlighting for help files"
HOMEPAGE="http://mysite.verizon.net/astronaut/vim/"
LICENSE="as-is"
KEYWORDS="alpha amd64 arm hppa ia64 mips ~ppc ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides additional syntax highlighting for help files."

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# use hi def link, bug #101797 / bug #101804
	sed -i -e 's,^hi link,hi def link,' \
		"after/syntax/help.vim.d/extra-help-syntax.vim" || die "sed failed"
}

