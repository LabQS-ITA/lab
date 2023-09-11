#!/bin/bash

trap  "echo TRAPed signal" HUP INT QUIT TERM

envconsul -consul-addr=consul:8500 -consul-token=$CONSUL_TOKEN \
    -prefix=labqs/redmine rails server -b 0.0.0.0
