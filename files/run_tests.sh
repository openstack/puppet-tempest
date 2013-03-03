#!/bin/bash
#
# script that sets up a virtualenv and runs the tempest tests
set -e
pip install virtualenv
virtualenv test_env --system-site-packages
source test_env/bin/activate
pip install -I anyjson nose httplib2 pika unittest2 lxml testtools testresources paramiko
./run_tests.sh $*
