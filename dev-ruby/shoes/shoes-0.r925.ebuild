# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Shoes is a very informal graphics and windowing toolkit for Ruby."
HOMEPAGE="http://shoooes.net/"
SRC_URI="http://shoooes.net/dist/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vlc curl sqlite3 examples"

DEPEND="
	x11-libs/cairo
	media-libs/libpixman
	x11-libs/pango
	dev-lang/ruby
	x11-libs/gtk+
	media-libs/jpeg
	vlc? ( media-video/vlc )
	curl? ( net-misc/curl )
	sqlite3? ( >=dev-db/sqlite-3 )
	"

src_install() {
	if use vlc; then
		emake VIDEO=1
	fi
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG COPYING README static/manual.txt

	if use examples; then
		docinto /usr/share/shoes/samples/
		dodoc "${S}"/samples/*
	fi
}
