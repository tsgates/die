#!/bin/bash

docker run --rm \
       --volume "$(pwd):/data" \
       --user $(id -u):$(id -g) \
       tsgatesv/die:latest make "$@"
