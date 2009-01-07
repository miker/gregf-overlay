# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib games

DESCRIPTION="First person shooter from 3D Realms"
HOMEPAGE="http://icculus.org/prey/ http://www.3drealms.com/prey/"
SRC_URI="http://icculus.org/prey/downloads/prey-demo-installer-${PV}.bin"

LICENSE="PREY PUNKBUSTER"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openal opengl dedicated"
PROPERTIES="interactive"
RESTRICT="strip mirror"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/libSDL-1.2.so.0
		${GAMES_PREFIX_OPT:1}/${PN}/pb/pbag.so
		${GAMES_PREFIX_OPT:1}/${PN}/pb/pbcl.so
		${GAMES_PREFIX_OPT:1}/${PN}/pb/pbsv.so"

DEPEND="app-arch/unzip"
RDEPEND="opengl? ( virtual/opengl )
	openal? ( x86? ( media-libs/openal )
		  amd64? ( app-emulation/emul-linux-x86-sdl ) )
	sys-libs/glibc"

S=${WORKDIR}

GAMES_CHECK_LICENSE="no"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	unzip ${DISTDIR}/prey-demo-installer-${PV}.bin &> /dev/null	
}

src_install() {
	cd ${S}
	dodir "${dir}"

	insinto "${dir}"
	doins data/prey_demo_readme.txt data/prey_demo_license.txt \
		data/punkbuster_license.txt || die "doins texts"
	doins -r data/punkbuster-linux-x86/pb || die "doins punkbuster"

	exeinto "${dir}"
	doexe data/prey-demo-linux-x86/libgcc_s.so.1 \
		data/prey-demo-linux-x86/prey-demo.x86 \
		data/prey-demo-linux-x86/libSDL-1.2.so.0 \
		data/prey-demo-linux-x86/libNvidiaVidMemTest.so \
		data/prey-demo-linux-x86/prey-demo \
		data/prey-demo-linux-x86/libstdc++.so.5 || die "doexe executables"
	
	exeinto "${dir}/base"
	doexe data/prey-demo-linux-x86/base/gamex86.so || die "doexe base/gamex86.so"

	insinto "${dir}/base"
	doins -r data/prey-demo-linux-data/base/* || die "doins data"

	if use openal; then
		dosym /usr/$(get_libdir)/libopenal.so ${dir}/openal.so
	fi

	newicon data/prey-demo-linux-data/prey.png ${PN}.png

	games_make_wrapper ${PN} ./prey-demo "${dir}" "${dir}"
	make_desktop_entry ${PN} "Prey (Demo)"

	prepgamesdirs
}
