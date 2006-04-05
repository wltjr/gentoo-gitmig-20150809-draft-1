# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/foldutil/foldutil-2.0.ebuild,v 1.6 2006/04/05 13:58:58 chutzpah Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: fold creation utility"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=158"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 mips ppc sparc x86"
IUSE=""

RDEPEND="
	>=app-vim/multvals-3.10
	>=app-vim/genutils-1.18"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a number of commands for working with folds:
\    :FoldNonMatching [pattern] [context]
\    :FoldShowLines   {lines} [context]
\    :FoldEndFolding"
