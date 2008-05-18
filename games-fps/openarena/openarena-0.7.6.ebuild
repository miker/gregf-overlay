# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/openarena/openarena-0.7.1.ebuild,v 1.4 2008/02/29 19:17:41 carlo Exp $

inherit eutils versionator games

MY_PV=$(delete_all_version_separators)

DESCRIPTION="Open-source replacement for Quake 3 Arena"
HOMEPAGE="http://openarena.ws/"
SRC_URI="http://download.tuxfamily.org/openarena/rel/"${MY_PV}"/oa"${MY_PV}".zip
	http://openarena.ws/svn/source/"${MY_PV}"/ioquake3svn1288plus4.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated smp"

RDEPEND="virtual/opengl
	media-libs/openal
	media-libs/libsdl
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"
DEPEND="app-arch/unzip"


MY_S="${WORKDIR}"/ioquake3svn1288
build_dir=build
dir="${GAMES_DATADIR}"/"${PN}"


src_compile() {
	cd "${MY_S}"
	emake \
		DEFAULT_BASEDIR="${dir}" \
		BR="${build_dir}" \
		BUILD_GAME_SO=0 \
		BUILD_GAME_QVM=0 \
		$(! use dedicated && echo BUILD_SERVER=0) \
		$(use smp && echo BUILD_CLIENT_SMP=1) \
		|| die "emake failed"
}

src_install() {
	local ded_exe="ioq3ded" exe="ioquake3"

	if use smp ; then
		exe="${exe}"-smp
	fi

	newgamesbin "${MY_S}"/"${build_dir}"/"${exe}".* "${PN}" || die

	if use dedicated ; then	
		newgamesbin "${MY_S}"/"${build_dir}"/"${ded_exe}".* "${PN}"-ded || die
	fi

	insinto "${dir}"
	doins -r baseoa || die "doins -r failed"
	
	dodoc CHANGES CREDITS LINUXNOTES README

	newicon "${MY_S}"/misc/quake3.png "${PN}".png
	make_desktop_entry "${PN}" "OpenArena" "${PN}"

	prepgamesdirs
}
