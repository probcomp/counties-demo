#!/bin/bash
set -e

dockerize -wait tcp://bayesrest:5000
/usr/local/bin/start.sh $*
