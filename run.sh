#!/usr/bin/env bash

docker run -v "$PWD:/root/tinkuy" -p "3000:3000" -it tinkuy.dk
