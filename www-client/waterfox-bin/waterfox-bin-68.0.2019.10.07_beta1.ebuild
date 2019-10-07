# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit desktop gnome2-utils pax-utils xdg-utils

KEYWORDS="~ppc64"
DESCRIPTION="Waterfox Web Browser (Binary package)"
HOMEPAGE="https://www.waterfoxproject.org/"

SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE=""

BIN_PN="${PN/-bin/}"
ALPHA_PV="68.0a2"
RESTRICT="strip mirror"
SRC_URI="
	ppc64? ( https://github.com/djames1/waterfox-ppc64le-bin/releases/download/68.0b1-2019.10.07/waterfox-68.0.en-US.linux-powerpc64le.tar.bz2 )
"

RDEPEND="
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.60
	media-libs/alsa-lib
	media-libs/fontconfig
	>=media-libs/freetype-2.1.0
	>=x11-libs/gtk+-3.4
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/pango
	virtual/freedesktop-icon-theme
	virtual/ffmpeg[x264]
"

QA_PREBUILT="
	opt/${BIN_PN}/*.so
	opt/${BIN_PN}/${BIN_PN}
	opt/${BIN_PN}/${PN}
"

S="${WORKDIR}/${BIN_PN}"

src_unpack() {
	unpack ${A}
}

src_install() {
	local size sizes icon_path icon name
	sizes="16 32 48 128"
	icon_path="${S}/browser/chrome/icons/default"
	icon="${PN}"

	# Install icons and .desktop for menu entry:
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png" || die
	done
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs:
	newicon "${S}"/browser/chrome/icons/default/default48.png ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop

	#make_desktop_entry ${PN} "Waterfox Web Browser" ${PN} "Network;WebBrowser;"

	# Install in /opt:
	dodir "opt/"
	mv "${S}" "${ED}"/opt/ || die

	# Create wrapper:
	dodir /usr/bin/
	cat <<-EOF >"${ED}"usr/bin/${PN}
	#!/bin/sh
	GTK_PATH=/usr/lib/gtk-3.0/
	exec /opt/${BIN_PN}/${BIN_PN} "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	# revdep-rebuild entry:
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=/opt/${BIN_PN}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die

	# Plugins dir:
	dosym "/usr/$(get_libdir)/nsbrowser/plugins" "/opt/${BIN_PN}/browser/plugins"

	# Disable auto-update, because Waterfox is updated through package manager
	insinto /opt/${BIN_PN}/distribution/
	newins "${FILESDIR}/disable-auto-update.policy.json" policies.json

	# Required in order to use plugins and even run waterfox on hardened:
	pax-mark mr "${ED}"opt/${BIN_PN}/{${PN},${BIN_PN},plugin-container}
}

pkg_preinst() {
	xdg_environment_reset
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
