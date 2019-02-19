# ppc64le-overlay
Gentoo Overlay for PPC64 Little Endian Patches/Fixes. This overlay may be useful for big endian users as well, however the focus is little endian.

## Installing Overlay
To install this overlay, please run the following:
`layman -o https://raw.githubusercontent.com/djames1/ppc64le-overlay/master/repository.xml -L -a ppc64le`

## List of Packages
* `www-client/firefox-bin`
    * I could not get Firefox built with portage to work without crashing when typing in the address bar. If I build outside of portage it works fine.
    * See https://github.com/djames1/firefox-ppc64le-bin
