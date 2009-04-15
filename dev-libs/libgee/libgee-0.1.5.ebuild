# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="Library providing GObject-based interfaces and classes for commonly used data structures"
HOMEPAGE="http://live.gnome.org/Libgee"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/0.1/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/vala-0.3.3
	>=dev-libs/glib-2.10"
DEPEND="${RDEPEND}"
