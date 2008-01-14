# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator games

VER="$(get_version_component_range 1-2)"
REV="$(get_version_component_range 3-3)"
MY_PV="${VER}-full.r${REV}"
MY_BODY="ETQW-demo-client-${MY_PV}.x86"

DESCRIPTION="Enemy Territory: Quake Wars demo"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
SRC_URI="${MY_BODY}.run"

# See copyrights.txt
LICENSE="ETQW"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="x86? (
		media-libs/libsdl
		virtual/opengl
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext )
	amd64? ( >=app-emulation/emul-linux-x86-sdl-10.1 )"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}

QA_TEXTRELS="${dir:1}/data/pb/pbsv.so
	${dir:1}/data/pb/pbag.so
	${dir:1}/data/pb/pbcls.so
	${dir:1}/data/pb/pbcl.so
	${dir:1}/data/pb/pbags.so
	${dir:1}/guis/libmojosetupgui_ncurses.so"

QA_EXECSTACK="${dir:1}/data/libstdc++.so.6
	${dir:1}/data/etqwded.x86
	${dir:1}/data/libgcc_s.so.1
	${dir:1}/data/etqw.x86
	${dir:1}/guis/libmojosetupgui_ncurses.so"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	echo
}

src_unpack() {
	# unpack_makeself cannot detect the version
	tail -c +677092 "${DISTDIR}/${MY_BODY}.run" > ${PN}.zip || die
	unpack ./${PN}.zip
	rm -f ${PN}.zip || die
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins"

	cd data
	exeinto "${dir}"/data
	doexe et* lib* *.sh || die "doexe"

	games_make_wrapper ${PN} ./etqw.x86 "${dir}"/data "${dir}"/data
	games_make_wrapper ${PN}-ded ./etqwded.x86 "${dir}"/data "${dir}"/data

	prepgamesdirs
}
