# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit distutils

DESCRIPTION="gPodder is a Podcast receiver/catcher written in Python, using GTK."
HOMEPAGE="http://gpodder.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipod libnotify mad ogg bluetooth mtp gtkhtml rockbox dbus"
RESTRICT="test"

RDEPEND="dev-python/feedparser
    dev-python/pygtk
    sys-devel/gettext
    libnotify? ( dev-python/notify-python )
    >=dev-python/pysqlite-2.4
    dev-python/eyeD3
    dbus? ( dev-python/dbus-python )
    bluetooth? ( dev-python/pybluez )
    gtkhtml? ( dev-python/gtkhtml-python )
    mtp? ( dev-python/pymtp )
    ipod? ( media-libs/libgpod[python] )
    mad? ( dev-python/pymad )
    rockbox? ( dev-python/imaging )
    ogg? ( media-sound/vorbis-tools )
    =dev-python/mygpoclient-1.1"
DEPEND="${RDEPEND}
    dev-util/intltool
    media-gfx/imagemagick[png]
    sys-apps/help2man"

src_compile() {
    emake messages data/org.gpodder.service || die
    distutils_src_compile || die
}
