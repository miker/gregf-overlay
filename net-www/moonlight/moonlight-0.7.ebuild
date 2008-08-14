# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils flag-o-matic multilib nsplugins

DESCRIPTION="Moonlight is an open source implementation of Microsoft Silverlight
for Unix systems"
HOMEPAGE="http://www.go-mono.com/moonlight/"
SRC_URI="ftp://ftp.novell.com/pub/mono/sources/moon/moon-${PV}.tar.bz2"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="+ffmpeg mono +nsplugin"


DEPEND="ffmpeg? ( media-video/ffmpeg )
		mono? ( dev-lang/mono )
		media-sound/alsa-headers
		media-sound/alsa-tools
	|| (	>=www-client/mozilla-firefox-bin-2.0.0.14
		>=www-client/mozilla-firefox-2.0.0.14 )
		dev-libs/nspr
		 dev-libs/nss
		 net-libs/libgssglue
	app-text/opensp
	net-libs/xulrunner
				"
RDEPEND="${DEPEND}"

S="${WORKDIR}/moon-${PV}"

MAKEOPTS="-j1"

pkg_setup() {
	if ! built_with_use dev-lang/mono moonlight; then
		eerror "${CATEGORY}/${PN} requires dev-lang/mono  be built with
		moonlight USE flag for SilverLight 2.0 API support." 
		die "Please, reemerge dev-lang/mono with moonlight USE flag enabled."
	fi
}


#Fix me
RESTRICT="test"
# Issues with ld, xulrunner maybe?
src_test() {
# Work in Progress	
#	if ! built_with_use x11-libs/cairo png; then
#		eerror "${CATEGORY}/${PN} - TESTS, requires x11-libs/cairo to be built with png
#		USE flag."
#		die "Please, x11-libs/cairo with png USE flag enabled."
#	fi

	cd ${S}/test
	make check || die "tests failed"

	cd ${S}/plugin
	make test-plugin || die "plugin tests failed"
	make untest-plugin || ewarn "plugin tests not removed"
}

src_compile() {
	local myconf
	#Not completely confirmed optimization issues
	filter-flags '-O*'
	# --no-as-needed doesn't work there
	filter-ldflags --as-needed
	# GCC gets angry at mfpath - testing
	filter-mfpmath  sse
	
	if has_version '>=www-client/mozilla-firefox-3.0' ; then
		myconf="${myconf} --with-ff3=yes --enable-optimize=-O1"
	fi	

	if use ffmpeg ; then
		myconf="${myconf} --with-ffmpeg=yes"
	fi			

	if use mono ; then
		myconf="${myconf} --with-mono-runtime"
	fi

	econf \
		--enable-user-plugin \
		--target=${CHOST} \
		${myconf} || die "econf failed"
	
	emake LDFLAGS="$(raw-ldflags)" || die
}

src_install(){
	emake DESTDIR="${D}" install || die install failed
	
	if use nsplugin ; then
		cd ${S}/plugin/install
			exeinto /usr/$(get_libdir)/${PLUGINS_DIR}
			doexe novell-moonlight.xpi
	fi
	cd ${S}
	dodoc README AUTHORS NEWS TODO 
}	

pkg_postinst(){
	einfo 
	einfo "To launch Firefox with shape caching and ffmpeg converters use:"
	einfo
	einfo '$> MOONLIGHT_OVERRIDES="shapecache=yes,converter=ffmpeg" firefox'
}
