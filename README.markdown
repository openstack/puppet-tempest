Module for installing and configuring tempest.

Tempest is the test suite that can be used to run integration
tests on an installed openstack environment.

This module installs an environment.

Even after this script runs, it is still necessary to
manually install an image, and insert that images id
into /var/lib/tempest/etc/tempest.conf.

