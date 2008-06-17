# CVS ebuild for Conky, thanks to Hopeless
# $Header$

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/conky"
ECVS_MODULE="conky2"
inherit cvs

DESCRIPTION="Conky is an advanced, highly configurable system monitor for X"
HOMEPAGE="http://conky.sf.net"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="X"

DEPEND_COMMON="
    virtual/libc
    X? (
        >=x11-libs/cairo-0.9.2
		>=media-libs/libsvg-0.1.3
		>=x11-libs/libsvg-cairo-0.1.6
    )"


RDEPEND="${DEPEND_COMMON}
   "

DEPEND="
   ${DEPEND_COMMON}
   >=sys-devel/automake-1.9
   >=sys-devel/autoconf-2.59
   sys-devel/libtool
   sys-apps/grep
   sys-apps/sed
   sys-devel/gcc
   "

S=${WORKDIR}/conky2

src_unpack() {
        cvs_src_unpack
        cd ${S}
        NOCONFIGURE=blah ./autogen.sh
}

src_compile() {
   econf \
	  $(use_enable X x11) \
      || die "econf failed"
   emake || die "compile failed"
}

src_install() {
   emake DESTDIR=${D} install || die "make install failed"
   dodoc ChangeLog AUTHORS README doc/conkyrc.sample doc/variables.html
   dodoc doc/docs.html doc/config_settings.html
}
