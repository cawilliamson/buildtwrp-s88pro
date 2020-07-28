#!/usr/bin/env bash

# run docker build
echo "[*] Building docker container"
docker build -t chrisawcom/buildtwrp .

# docker run
echo "[*] Starting ROM build"
docker run --privileged --tty --rm -v "$(pwd):/var/tmp/buildtwrp" -v "$(pwd)/out:/var/tmp/buildrom/out" chrisawcom/buildrom
