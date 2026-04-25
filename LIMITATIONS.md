# Limitations

## Package Availability

`fail2ban` is installed from operating system package repositories. The cookbook
does not compile fail2ban from source.

### APT (Debian/Ubuntu)

* Debian 12 (Bookworm): `fail2ban` 1.0.2 is available in the Debian archive.
* Debian 13 (Trixie): `fail2ban` 1.1.0 is available in the Debian archive.
* Ubuntu 22.04 (Jammy): `fail2ban` 0.11.2 is available in Ubuntu Universe.
* Ubuntu 24.04 (Noble): `fail2ban` 1.0.2 is available in Ubuntu Universe, with 1.0.2-3ubuntu0.1 in updates.

### DNF/YUM (RHEL family)

* AlmaLinux, CentOS Stream, Oracle Linux, Red Hat, and Rocky Linux 8: `fail2ban` is available from EPEL 8.
* AlmaLinux, CentOS Stream, Oracle Linux, Red Hat, and Rocky Linux 9: `fail2ban` is available from EPEL 9.
* AlmaLinux, CentOS Stream, Red Hat, and Rocky Linux 10: `fail2ban` is available from EPEL 10.
* CentOS Stream 10: EPEL 10 is used, but EPEL Next is disabled because `epel-next-10` mirror metadata currently returns 404 for `aarch64`.
* Amazon Linux 2023: `fail2ban` is available from Amazon Linux 2023 repositories and does not require EPEL.
* Fedora 42, 43, 44, and Rawhide: `fail2ban` packages are available from Fedora repositories.

### Zypper (SUSE)

* openSUSE Leap 15.6 reaches EOL on 2026-04-30.
* openSUSE Leap 16.0 has no official `fail2ban` package listed by openSUSE Software.
* SUSE/openSUSE support is not included in this migration until a supported Leap release has an official package and matching Dokken coverage.

## Architecture Limitations

* Debian and Ubuntu publish the `fail2ban` binary package as architecture `all`.
* Fedora/EPEL and Amazon Linux publish the main fail2ban packages as `noarch`.
* No source build path is implemented by this cookbook.

## Source/Compiled Installation

This cookbook does not build fail2ban from source. Users who require source
installs should wrap this cookbook with a site-specific resource.

## Platform Lifecycle Decisions

* Removed Debian 9, Debian 10, Debian 11, Ubuntu 18.04, Ubuntu 20.04, Amazon Linux 2, CentOS 7, CentOS 8, Scientific Linux, and openSUSE Leap 15 from test coverage because they are EOL or effectively EOL for this cookbook's supported package path.
* Added Debian 13, AlmaLinux 10, CentOS Stream 10, and Rocky Linux 10 where package availability and Dokken images support testing.
