# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/urbanterror/ubanterror-4.1.ebuild,v 1.1 2007/08/18 00:46:11 wolf31o2 Exp $

inherit games 

EAPI="1"
HOMEPAGE="http://www.urbanterror.net/"
DESCRIPTION="Quake III Urban Terror - total transformation realism based MOD"
SRC_URI="
	ftp://ftp.snt.utwente.nl/pub/games/urbanterror/UrbanTerror_41_FULL.zip
	http://mirror.kickassctf.com/UrbanTerror_41_FULL.zip
	http://mrsentry.net/release/UrbanTerror_41_FULL.zip
	http://www.iourt.com/urt41/UrbanTerror_41_FULL.zip
	http://mirror.ncsa.uiuc.edu/ut4/urbanterror/UrbanTerror_41_FULL.zip"

LICENSE="freedist"
SLOT="0"
RESTRICT="mirror strip"

KEYWORDS="-* ~amd64 ~x86"
DEPEND="app-arch/unzip"

RDEPEND="
        sys-libs/glibc
        opengl? (
                x11-libs/libXext
                x11-libs/libX11
                x11-libs/libXau
                x11-libs/libXdmcp
                sys-libs/gpm
                sys-libs/ncurses
                media-libs/libsdl
                media-libs/aalib
        )
        "

S=${WORKDIR}

GAMES_CHECK_LICENSE="no"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack ${A}
}

src_install() {
	exeinto ${dir}
		doexe "UrbanTerror"/ioUrbanTerror.i386 || die "doexe ioUrT"
	insinto ${dir}
	doicon q3ut4/q3ut.ico
	
	cp -r UrbanTerror/* "${Ddir}" || die "cp failed"

	games_make_wrapper urbanterror ./ioUrbanTerror.i386 "${dir}" "${dir}"
	make_desktop_entry urbanterror "UrbanTerror" UrT
	prepgamesdirs
	chmod g+rw "${Ddir}" "${Ddir}/ioUrbanTerror.i386"
}
