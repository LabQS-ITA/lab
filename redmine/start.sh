#!/bin/bash

trap  "echo TRAPed signal" HUP INT QUIT TERM

rails server --log-to-stdout --daemon --binding=0.0.0.0 --port=3000 --environment=development

echo "exited $0"
