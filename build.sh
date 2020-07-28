#!/usr/bin/env bash

# run docker build
echo "[*] Building docker container"
docker build -t chrisawcom/buildtwrp .

# docker run
echo "[*] Starting TWRP build"
docker run --privileged --tty --rm -v "$(pwd):/var/tmp/buildtwrp" chrisawcom/buildtwrp

# sign recovery image
echo "[*] Sign recovery image"
./avbtool add_hash_footer --image recovery.img --partition_name recovery --partition_size 33554432 --key rsa2048_vbmeta.pem --algorithm SHA256_RSA2048
