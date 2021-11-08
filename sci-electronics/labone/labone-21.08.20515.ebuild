# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd udev

DESCRIPTION="Platform independent instrument control for Zurich Instruments devices"
HOMEPAGE="https://www.zhinst.com/labone"
SRC_URI="https://www.zhinst.com/sites/default/files/media/release_file/2021-09/LabOneLinux64-${PV}.tar.gz"

LICENSE="zi-labone"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror bindist"
IUSE="minimal"

QA_PREBUILT="*"

RDEPEND=""

S=${WORKDIR}/LabOneLinux64-${PV}

src_install() {
	local application_directory=/opt/zi
	local installation_directory="${application_directory}/LabOne64-${PV}"

	if ! use minimal ; then

		# the applications

		dodir ${installation_directory}
		for dir in API DataServer Firmware Documentation WebServer ; do
			mv "$dir" "${D}${installation_directory}/" || die
		done

		cp "release_notes_$(ver_cut 1-2).txt" "${D}${installation_directory}/" || die

		dosym ../..${application_directory}/DataServer/ziServer /opt/bin/ziServer
		dosym ../..${application_directory}/DataServer/ziDataServer /opt/bin/ziDataServer
		dosym ../..${application_directory}/DataServer/ziWebServer /opt/bin/ziWebServer

		# the services

		# LabOne comes with systemd support.

		local service
		for service in labone-data-server hf2-data-server ; do
			sed -e 's:/usr/local/bin/:/opt/bin/:g' -i Installer/systemd/${service}.service || die
			systemd_dounit Installer/systemd/${service}.service
		done

		# For OpenRC we need to do our own thing...

		for service in labone-data-server hf2-data-server ; do
			doinitd "${FILESDIR}/${service}"
			doconfd "${FILESDIR}/${service}.conf"
		done

	else

		insinto "${application_directory}/API/C/lib"
		doins API/C/lib/*.so
		insinto "${application_directory}/API/C/include"
		doins API/C/include/*.h

	fi

	dosym "../..${application_directory}/API/C/include/ziAPI.h" "usr/include/ziAPI.h"
	dosym "../..${application_directory}/API/C/lib/libziAPI-linux64.so" "usr/$(get_libdir)/libziAPI-linux64.so"

	udev_dorules Installer/udev/55-zhinst.rules
}
