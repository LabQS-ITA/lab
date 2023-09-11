#!/bin/bash

trap  "echo TRAPed signal" HUP INT QUIT TERM

envconsul -consul-addr=consul:8500 -consul-token=$CONSUL_TOKEN \
    -prefix=labqs/redmine rails server --log-to-stdout --daemon --binding=0.0.0.0
