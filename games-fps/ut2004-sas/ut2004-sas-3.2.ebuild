# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_NAME="SAS"
MOD_DESC="SAS vs terrorists team-based mod"
MOD_DIR="SAS"
MOD_BINS="sas"
MOD_ICON="sas.png"

inherit games games-mods

HOMEPAGE="http://www.sas.jolt.co.uk/"
SRC_URI="sas_${PV}_lnx.run"

# See Help/SASReadme.txt
LICENSE="as-is"

KEYWORDS="~amd64 ~x86"

RESTRICT="fetch"

RDEPEND="${CATEGORY}/${GAME}"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	echo
}

src_unpack() {
	games-mods_src_unpack
	unpack ./sas_${PV}.tar.bz2

	# Move icon to where the eclass expects
	mv sas.png "${MOD_DIR}"/ || die

	mv README.SAS "${MOD_DIR}"/Help/ || die
}
