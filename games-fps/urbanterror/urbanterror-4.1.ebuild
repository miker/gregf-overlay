# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games toolchain-funcs

DESCRIPTION="Hollywood tactical shooter based on the ioquake3 engine"
HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="ftp://ftp.snt.utwente.nl/pub/games/urbanterror/iourbanterror/source/complete/ioUrbanTerrorSource_2007_12_20.zip
	ftp://ftp.snt.utwente.nl/pub/games/urbanterror/UrbanTerror_41_FULL.zip
	http://files.uaaportal.com/gamefiles/current-version/UrbanTerror_41_FULL.zip
	http://upload.wikimedia.org/wikipedia/en/5/56/Urbanterror.svg"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="openal vorbis curl smp server client"

RDEPEND="curl? ( net-misc/curl )
	client? ( 
		vorbis? ( media-libs/libogg media-libs/libvorbis )
		openal? ( media-libs/openal )
		media-libs/libsdl
		virtual/opengl
	)"

S=${WORKDIR}

src_compile() {
	buildit() { use $1 && echo 1 || echo 0 ; }

	if use client ; then
		cd "${S}"/ioUrbanTerrorClientSource
		sed -i -e '16s/-Werror //' code/tools/asm/Makefile
		emake \
			$(use amd64 && echo ARCH=x86_64) \
			BUILD_CLIENT_SMP=$(buildit smp) \
			BUILD_GAME_SO=0 \
			BUILD_GAME_QVM=0 \
			CC="$(tc-getCC)" \
			DEFAULT_BASEDIR="${GAMES_DATADIR}/${PN}" \
			USE_CODEC_VORBIS=$(buildit vorbis) \
			USE_OPENAL=$(buildit openal) \
			USE_CURL=$(buildit curl) \
			USE_LOCAL_HEADERS=0 \
				|| die "emake client failed"
	elif use server ; then
		cd "${S}"/ioUrbanTerrorServerSource
		emake \
			$(use amd64 && echo ARCH=x86_64) \
			BUILD_GAME_SO=0 \
			BUILD_GAME_QVM=0 \
			CC="$(tc-getCC)" \
			DEFAULT_BASEDIR="${GAMES_DATADIR}/${PN}" \
			USE_CODEC_VORBIS=$(buildit vorbis) \
			USE_OPENAL=$(buildit openal) \
			USE_CURL=$(buildit curl) \
			USE_LOCAL_HEADERS=0 \
				|| die "emake server failed"
	fi
}

src_install() {
	use amd64 && ARCH=x86_64
	use x86 && ARCH=x86

	cd "${S}"

	if use client ; then
		if use smp ; then
			dogamesbin ioUrbanTerrorClientSource/build/release-linux-${ARCH}/ioUrbanTerror-smp.${ARCH}
			dosym ioUrbanTerror-smp.${ARCH} "${GAMES_BINDIR}"/urbanterror
			make_desktop_entry ioUrbanTerror-smp.${ARCH} "UrbanTerror" Urbanterror.svg
		else
			dogamesbin ioUrbanTerrorClientSource/build/release-linux-${ARCH}/ioUrbanTerror.${ARCH}
			dosym ioUrbanTerror.${ARCH} "${GAMES_BINDIR}"/urbanterror
			make_desktop_entry ioUrbanTerror.${ARCH} "UrbanTerror" Urbanterror.svg
		fi
	elif use server ; then
		dogamesbin ioUrbanTerrorServerSource/build/release-linux-${ARCH}/ioUrTded.${ARCH}
		dosym ioUrTded.${ARCH} "${GAMES_BINDIR}"/urbanterror
		make_desktop_entry ioUrTded.${ARCH} "UrbanTerror Server" Urbanterror.svg
	fi

	doicon ${DISTDIR}/Urbanterror.svg
	cd "${S}"/UrbanTerror/q3ut4
	mv demos/tutorial.dm_68 demos/TUTORIAL.dm_68
	dodoc readme41.txt
	insinto "${GAMES_DATADIR}"/${PN}/q3ut4
	doins -r *.pk3 autoexec.cfg demos/ description.txt mapcycle.txt screenshots/ server.cfg

	prepgamesdirs
}
