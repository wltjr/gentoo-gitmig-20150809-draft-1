# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gnupg/selinux-gnupg-2.20101213-r1.ebuild,v 1.1 2011/03/07 02:43:30 blueness Exp $

MODS="gpg"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for GNU privacy guard"

KEYWORDS="~amd64 ~x86"

POLICY_PATCH="${FILESDIR}/fix-apps-gpg-r1.patch"
