Tempest
=======

5.1.0 - 2014.2 - Juno

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

Release Notes
-------------

** 5.1.0 **

* spec: pin rspec-puppet to 1.0.1
* Update .gitreview file for project rename
* Allow to not manage Tempest code in Puppet
* Allow to activate Ceilometer tests

** 5.0.0 **

* Stable Juno release
* Pinned vcsrepo dependency to 2.x
* Bumped stdlib dependency to 4.x
* Added ability to hide secrets from puppet logs
* Removed orphaned os_concat function
* Removed dependencies on mysql and postgresql devel libraries
