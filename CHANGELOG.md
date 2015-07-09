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
