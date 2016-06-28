# atomic_scan_openscap

This image contains various pieces of the [openSCAP project](https://www.open-scap.org/) which when
used with the [atomic command line application](https://github.com/projectatomic/atomic) can scan
for vulnerabilities within a RHEL filesystem.  With the _atomic scan_ command, you can scan
containers and images as well as any root filesystem mounted to your host.

The atomic_scan_openscap image will not run stand-alone and must be run in conjunction with
_atomic scan_.

## Prerequisites

You must have docker and atomic installed on your system.

## Installation

To check if the atomic_scan_openscap is already configured for your system, use _atomic scan --list_.
If it is not configured, simply issue _atomic install docker.io/atomic_scan_openscap_.  This will pull
the image from the registry and copy its configuration file to /etc/atomic.d/.

A configuration file for the openscap-daemon is also placed in /etc/oscapd/.  This controls the
way openscap-daemon runs.

### Configuration

If you wish to make _atomic_scan_openscap_ your default atomic scanner, edit _/etc/atomic.conf_ and
alter the **default_scanner** value.

By default, the atomic_scan_openscap image will not fetch new CVE definitions by default.  To alter
this behavior, simply set **fetch-cve** to _yes_ in _/etc/oscapd/config.ini_.

### Building

docker build -t atomic_scan_openscap .

## Running

This image will only run in conjunction with atomic_scan.  

## Usage

atomic scan --scanner docker.io/atomic_scan_openscap <image|container names>

