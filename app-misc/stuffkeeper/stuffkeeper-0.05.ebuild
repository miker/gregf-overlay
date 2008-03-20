# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Stuffkeeper is a generic catalog program. It is not focused on a particular type, you define any amount of typesm, like audio-cd, dvd, serial-number, computer-hardware, etc."
HOMEPAGE="http://www.sarine.nl/stuffkeeper"
SRC_URI="http://download.sarine.nl/Programs/StuffKeeper/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="spell"

DEPEND=">=x11-libs/gtk+-2.10
		>=dev-libs/glib-2.10
		>=dev-db/sqlite-3
		>=gnome-base/libglade-2.6
		dev-lang/python
		dev-util/gob
		dev-util/intltool
		spell? ( app-text/gtkspell )"
RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--prefix=/usr
}

src_install() {
	dodoc AUTHORS LICENSE
	emake DESTDIR="${D}" install || die "emake install failed"
}
