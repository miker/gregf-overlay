inherit kde

DESCRIPTION="QuadKonsole embeds Konsole kparts in a grid layout."
HOMEPAGE="http://nomis80.org/"
SRC_URI="http://nomis80.org/quadkonsole/quadkonsole-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
need-kde 3.5

RDEPEND="x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXrandr
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXcursor"

DEPEND="${RDEPEND}
		sys-libs/libutempter
		>=media-libs/freetype-2.1.9-r1
		>=media-libs/libpng-1.2.14
		kde-base/kdebase"

src_compile() {
	kde_src_compile
}

src_install(){
	kde_src_install
	dodoc ChangeLog AUTHORS README TODO INSTALL
}
