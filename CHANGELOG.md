##2016-05-20 - 7.1.0

###Summary

This is a feature and bugfix release in the Liberty series.

####Features

- Switch id setters to openstack client

####Bugfixes

- venv: create venv & run pip in exec


##2015-11-25 - 7.0.0
###Summary

This is a backwards-compatible major release for OpenStack Liberty.

####Features
- allow to enable/disable Aodh service
- allow to enable/disable Trove service
- allow to enable/disable Sahara service
- add dashboard parameters
- add basic scenarios options
- allow to optionally git clone tempest
- reflect provider change in puppet-openstacklib

####Bugfixes
- make sure neutron network is created before Tempest_neutron_net_id_setter
- glance_id_setter: execute after creating Glance image
- fix ocnfiguration for glance/neutron setters

####Maintenance
- initial msync run for all Puppet OpenStack modules
- try to use zuul-cloner to prepare fixtures
- remove class_parameter_defaults puppet-lint check

##2015-10-10 - 6.1.0
###Summary

This is a maintenance and features release in Kilo series.

The tempest.conf.sample does not exist anymore so we need to stop relying on
this file to create the tempest.conf configuration file.

####Features
- Add tempest::config class
- Add config parameters to run Keystone v3 tests

####Maintenance
- acceptance: checkout stable/kilo puppet modules

####Bugfixes
- do not create tempest.conf from .sample file

##2015-07-08 - 6.0.0
###Summary

This is a major release for OpenStack Kilo.

####Features
- Puppet 4.x support
- Allow to activate Ceilometer tests
- Allow to not manage Tempest code in Puppet
- Implement more Tempest options

####Maintenance
- Acceptance tests with Beaker

##2015-06-17 - 5.1.0
###Summary

This is a feature and maintenance release in the Juno series.

####Features
- Allow to not manage Tempest code in Puppet
- Allow to activate Ceilometer tests

####Maintenance
- spec: pin rspec-puppet to 1.0.1
- Update .gitreview file for project rename

##2014-11-22 - 5.0.0
###Summary

Stable Juno release.

####Features
- Add ability to hide secrets from puppet logs

####Bugfixes
- Removed orphaned os_concat function

####Maintenance
- Pin vcsrepo dependency to 2.x
- Bump stdlib dependency to 4.x
- Remove dependencies on mysql and postgresql devel libraries
