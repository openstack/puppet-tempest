# == Class: tempest::config
#
# This class is used to manage arbitrary Tempest configurations.
#
# === Parameters
#
# [*tempest_config*]
#   (optional) Allow configuration of arbitrary Tempest configurations.
#   Note: The tempest_config provider does not hard-code the path
#   of the tempest config file so that tempest can be run out of temporary
#   locations (i.e. /tmp/tempest). For this reason, you MUST pass "path"
#   in this hash.
#   The value is an hash of tempest_config resources. Example:
#   { 
#     'DEFAULT/foo' => { path => '/tmp/tempest/etc/tempest.conf'; value => 'fooValue'},
#     'DEFAULT/bar' => { path => '/tmp/tempest/etc/tempest.conf'; value => 'fooValue'},
#   }
#   In yaml format, Example:
#   tempest_config:
#     DEFAULT/foo:
#       value: fooValue
#       path: /tmp/tempest/etc/tempest.conf
#     DEFAULT/bar:
#       value: barValue
#       path: /tmp/tempest/etc/tempest.conf
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class tempest::config (
  $tempest_config        = {},
) {

  validate_hash($tempest_config)

  create_resources('tempest_config', $tempest_config)
}
