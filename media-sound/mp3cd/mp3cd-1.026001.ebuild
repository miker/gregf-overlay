# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit perl-app

DESCRIPTION="Burns normalized audio CDs from lists of MP3s/WAVs/Oggs/FLACs"
HOMEPAGE="http://outflux.net/software/pkgs/mp3cd/"
SRC_URI="http://outflux.net/software/pkgs/mp3cd/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ogg flac gstreamer"

RDEPEND="app-cdr/cdrdao
		 media-sound/sox[mad]
		 media-sound/normalize[mad]
		 ogg? ( media-sound/vorbis-tools )
		 flac? ( media-libs/flac )
		 gstreamer? ( media-libs/gst-plugins-good )" 
DEPEND="${RDEPEND}
	    >=dev-lang/perl-5.6.0
	    dev-perl/Config-Simple"

src_install() {
	perl-module_src_install
	doman blib/man1/mp3cd.1 
}
