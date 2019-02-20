# ppc64le-overlay
Gentoo Overlay for PPC64 Little Endian Patches/Fixes. This overlay may be useful for big endian users as well, however the focus is little endian.

## Installing Overlay
To install this overlay, please run the following:
`layman -o https://raw.githubusercontent.com/djames1/ppc64le-overlay/master/repository.xml -L -a ppc64le`

## List of Packages
* `www-client/firefox-bin`
    * Firefox crashed when typing in address bar when built with emerge. When building by hand it worked fine.
    * See https://github.com/djames1/firefox-ppc64le-bin
    * Add the following to `/etc/portage/package.accept_keywords`:
        * `www-client/firefox-bin::ppc64le ~ppc64`

* `mail-client/thunderbird-bin`
    * Thunderbird would not start at all when built with emerge. When building by hand it worked fine.
    * See https://github.com/djames1/thunderbird-ppc64le-bin
    * Add the following to `/etc/portage/package.accept_keywords`:
        * `mail-client/thunderbird-bin::ppc64le ~ppc64`

* `games-emulation/mupen64plus-*`
    * Applied patch to makefiles to support ppc64le. Patches have been submitted to upstream
    * Add the following to `/etc/portage/package.accept_keywords`:
        * `games-emulation/mupen64plus-core::ppc64le ~ppc64`
	* `games-emulation/mupen64plus-rsp-hle::ppc64le ~ppc64`
	* `games-emulation/mupen64plus-glide64m2::ppc64le ~ppc64`
