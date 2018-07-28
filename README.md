Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-tempest.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

Tempest
=======

Module for installing and configuring tempest.

Tempest is the test suite that can be used to run integration
tests on an installed openstack environment.

This module assumes the provisioning of the initial OpenStack
resources has been done beforehand.

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

Contributors
------------

* https://github.com/openstack/puppet-tempest/graphs/contributors

Release Notes
-------------

* https://docs.openstack.org/releasenotes/puppet-tempest

Repository
----------

* https://git.openstack.org/cgit/openstack/puppet-tempest

Beaker-Rspec
------------

This module has beaker-rspec tests

To run:

```shell
bundle install
bundle exec rspec spec/acceptance
```
