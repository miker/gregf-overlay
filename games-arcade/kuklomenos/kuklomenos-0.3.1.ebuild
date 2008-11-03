# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="minimalistic SDL abstract shoot-em-up"
HOMEPAGE="http://mbays.freeshell.org/kuklomenos/"
SRC_URI="http://mbays.freeshell.org/kuklomenos/src/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/libsdl media-libs/sdl-gfx"
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins 10x20.fnt 7x13.fnt amiga_machines.mod || die "doins failed"

	dodoc README AUTHORS NEWS TODO BUGS ChangeLog

	prepgamesdirs
}
