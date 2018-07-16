#!/bin/bash
set -e

dockerize -wait tcp://bayesrest:5000 -timeout 180
/usr/local/bin/start.sh $*
