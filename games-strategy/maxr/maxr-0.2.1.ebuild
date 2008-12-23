# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="M.A.X. Reloaded"
HOMEPAGE="http://www.maxthegame.de/"
SRC_URI="http://www.maxthegame.de/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
		>=media-libs/sdl-mixer-1.2
		media-libs/sdl-net"
RDEPEND="${DEPEND}"
dir=${GAMES_DATADIR}/${PN}

src_compile() {
	cd "${S}"
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	dodoc ABOUT CHANGELOG INSTALL
	prepgamesdirs
}
