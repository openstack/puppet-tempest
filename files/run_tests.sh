#!/bin/bash
#
# script that sets up a virtualenv and runs the tempest tests
set -e
pip install virtualenv
virtualenv test_env
source test_env/bin/activate
pip install anyjson nose httplib2 pika unittest2 lxml testtools testresources
./run_tests.sh
