# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="Cisco video conferencing and online meeting software"
HOMEPAGE="https://www.webex.com/"
SRC_URI="https://binaries.webex.com/WebexDesktop-CentOS-Official-Package/Webex.rpm -> ${P}.rpm"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="
	media-libs/alsa-lib
	app-accessibility/at-spi2-atk
	dev-libs/atk
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libnotify
	app-crypt/libsecret
	dev-libs/wayland
	x11-libs/libxkbcommon
	sys-apps/lshw
	media-libs/libglvnd
	media-libs/mesa
	dev-libs/nss
	x11-libs/pango
	media-sound/pulseaudio
	sys-apps/systemd
	sys-power/upower
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
"

S=${WORKDIR}

QA_PREBUILT="*"

src_install() {
	mv opt "${D}/" || die
	dodir /usr/lib/debug
	mv usr/lib/.build-id "${D}/usr/lib/debug/" || die

	domenu "${D}/opt/Webex/bin/webex.desktop"
}
