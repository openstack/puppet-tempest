# == Class: tempest::config
#
# This class is used to manage arbitrary Tempest configurations.
#
# === Parameters
#
# [*tempest_config*]
#   (optional) Allow configuration of arbitrary Tempest configurations.
#   The value is an hash of tempest_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   tempest_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
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
