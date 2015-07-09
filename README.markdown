Tempest
=======

6.0.0 - 2015.1 - Kilo

Module for installing and configuring tempest.

Tempest is the test suite that can be used to run integration
tests on an installed openstack environment.

This module assumes the provisioning of the initial OpenStack
resources has been done beforehand.

Beaker-Rspec
------------

This module has beaker-rspec tests

To run:

``shell
bundle install
bundle exec rspec spec/acceptance
``
