# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-log4j/ant-apache-log4j-1.7.0.ebuild,v 1.2 2007/01/22 10:29:25 flameeyes Exp $

ANT_TASK_DEPNAME="log4j"

inherit ant-tasks

KEYWORDS="~x86 ~x86-fbsd"

DEPEND=">=dev-java/log4j-1.2.13-r2"
RDEPEND="${DEPEND}"
