# ppc64le-overlay
Gentoo Overlay for PPC64 Little Endian Patches/Fixes. This overlay may be useful for big endian users as well, however the focus is little endian.

## Installing Overlay
To install this overlay, please run the following:
`layman -o https://raw.githubusercontent.com/djames1/ppc64le-overlay/master/repository.xml -L -a ppc64le`

## List of Packages
* `www-client/firefox`
    * Gentoo by default builds with `--enable-release`. This causes segfaults on ppc64le. We build it with `--disable-release`.
    * Disable gold linker as it will fail during linking on ppc64le
    * Always enable skia as it is required in newer firefox. This will be helpful for big endian users.
    * Disable `jemalloc`. Supposedly this isn't needed as of Firefox 65, but we do it anways to be safe.
    * Set the `system-*` use flags not to be set by default.
