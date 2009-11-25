# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils mercurial

DESCRIPTION="subtle is a semi-automatic tiling window manager"
HOMEPAGE="http://unexist.scrapping.cc/projects/subtle/"
SRC_URI=""
EHG_REPO_URI="http://hg.scrapping.cc/subtle"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="x11-libs/libX11
         dev-lang/ruby"
DEPEND="${RDEPEND}
        >=sys-devel/gcc-4.3
        dev-util/mercurial
        dev-ruby/rake"
S="${WORKDIR}/${PN}"


src_compile() {
	# It seems /usr/local/share is first sometimes.
	export XDG_DATA_DIRS="/usr/share:${XDB_DATA_DIRS//\/usr\/share:/}"

	rake destdir="${D}" config || die "rake config failed"
	rake build || die "rake build failed"
}

src_install() {
	rake install || die "rake install failed"
}
