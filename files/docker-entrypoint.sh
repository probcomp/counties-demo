#!/bin/bash
set -e

chown -R $NB_UID /home/$NB_USER/
dockerize -wait tcp://bayesrest:5000

exec "$@"
