#!/bin/bash

set -e

cd /var/www/Chaos
pip install -r requirements.txt
pip install -r requirements/test.txt

CHAOS_CONFIG_FILE=../docker/testing_settings.py nosetests

CHAOS_CONFIG_FILE=../docker/testing_settings.py lettuce tests/features
