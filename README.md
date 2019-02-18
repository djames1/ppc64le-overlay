# ppc64le-overlay
Gentoo Overlay for PPC64LE Patches/Fixes

## Installing Overlay
To install this overlay, please run the following:
`layman -o https://raw.githubusercontent.com/djames1/ppc64le-overlay/master/repository.xml -L -a ppc64le`

## List of Packages
* `www-client/firefox`
    * Gentoo by default builds with --enable-release. This segfaults on ppc64le. We build it with --disable-release.
    * Disable gold linker as it will fail during linking on ppc64le
