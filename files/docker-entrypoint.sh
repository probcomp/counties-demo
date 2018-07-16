#!/bin/bash
set -e

dockerize -wait tcp://bayesrest:5000 -timeout 180s
/usr/local/bin/start.sh $*
