# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Unix idle daemon to logout idle terminal sessions"
HOMEPAGE="http://www.darkwing.com/idled/"
SRC_URI="http://www.netsw.org/system/tools/process/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SOURCE="${FILESDIR}" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
}

src_compile() {
	emake clean || die "email clean failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install
}

pkg_postinst() {
	einfo ""
	einfo ""
	einfo "Be sure to edit/create the file /etc/idled.cf based on"
	einfo "the needs for your system. The /etc/idled.cf.template" 
	einfo "file can serve as a guide, as well as the man pages."
	einfo ""
	einfo ""
}
