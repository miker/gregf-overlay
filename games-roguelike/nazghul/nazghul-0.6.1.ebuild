# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="A role-playing game engine modeled after Ultima V"
HOMEPAGE="http://myweb.cableone.net/gmcnutt/nazghul.html"
SRC_URI="mirror://sourceforge/nazghul/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
		>=media-libs/sdl-image-1.2.4
		media-libs/libpng"

src_unpack() {
		unpack ${A}
		cd "${S}"
}

src_compile() {
		egamesconf || die
		emake || die "emake failed"
}

src_install() {
		make DESTDIR="${D}" install || die "make install failed"
		dodoc doc/{GAME_RULES,GHULSCRIPT,MAP_HACKERS_GUIDE,USERS_GUIDE} 
		docinto world_building 
		dodoc doc/world_building/*.txt
		prepgamesdirs
}
