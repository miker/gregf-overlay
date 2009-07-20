# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A log monitor similar to logsentry."
HOMEPAGE="http://logcheck.alioth.debian.org/"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl
	app-misc/lockfile-progs
	!app-admin/logsentry"

src_compile() {
	return
}

pkg_setup() {
	enewuser logcheck
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	fowners -R logcheck:logcheck /etc/logcheck /var/lock/logcheck /var/lib/logcheck

	dodoc AUTHORS CHANGES CREDITS TODO
	dodoc docs/README.*
	doman docs/logtail.8

	touch "${D}"/var/lock/logcheck/.keep
	touch "${D}"/var/lib/logcheck/.keep
}

pkg_config() {
	elog "Adding read-only permission for logcheck group on:"

	local skipped=0
	local inexistent=0
	IFS_BCK="$IFS"
	IFS=$'\n'
	local list=($(grep -vE '(^[[:space:]]*($|(#|!|;|//)))' /etc/logcheck/logcheck.logfiles | sed -e 's/^ *//' -e 's/ *$//'))
	IFS="$IFS_BCK"
	for i in "${list[@]}"; do
	     if [[ -e "${i}" ]]
	     then
	          local owner=$(ls -l "${i}" | cut -d' ' -f 3)
	          local group=$(ls -l "${i}" | cut -d' ' -f 4)
	          if [[ "${owner}" = "${group}"  ||  "${group}" = "logcheck" ]]
	          then
	               elog "   ${i}"
	               chgrp logcheck "${i}"
	               chmod g=r "${i}"
	          else
		       skipped=1
	               ewarn "   ${i} -- SKIPPED"
	          fi
	     else
                  inexistent=1
		  eerror "   ${i} -- Doesn't Exist!"
	     fi
	done

	if [ ${skipped} = 1 ]
	then
	   einfo
	   ewarn "You need to manually set read perm for logcheck"
	   ewarn "(user and/or group) on the skipped files."
	   ewarn "e.g., chgrp logcheck /var/log/useful.log"
	fi

	if [ ${inexistent} = 1 ]
	then
	   einfo
	   eerror "You need to remove non-existent files from your"
	   eerror "\"/etc/logcheck/logcheck.logfiles\" file"
	   eerror "or the program will fail."
	fi
}

pkg_postinst() {
	einfo
	elog "Please edit \"/etc/logcheck/logcheck.logfiles\" file"
	elog "and add the log files you want to monitor"
	einfo
	elog "*AFTER* this you can run \"emerge --config =${CATEGORY}/${PF}\""
	elog "to set read-only permission for 'logcheck' group on those files"
	einfo
	elog "Please notice that programs like syslog-ng must be configured accordingly:"
	elog "e.g, destination authlog { file("/var/log/auth.log" group("logcheck") perm(0640)); };"
	einfo
	elog "You probably want to add logcheck to cron, you can simply run:"
	elog "   crontab -u logcheck ${PORTDIR}/${CATEGORY}/${PN}/files/logcheck.cron.d"
	elog "or use this file as starting point."
}
