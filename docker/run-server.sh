#!/bin/bash

cd /var/www/Chaos

pip install -r requirements.txt

# Compîle protobuf files if needed
./setup.py build_pbf

exec /run.sh
