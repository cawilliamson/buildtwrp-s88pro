#!/usr/bin/env bash

# clone manifest repo
git clone --depth=1 https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0 /usr/src/twrp

# change to twrp build dir
cd /usr/src/twrp

# init repo
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0

# create roomservice file
mkdir -p .repo/local_manifests/
cp -v /var/tmp/buildtwrp/roomservice.xml .repo/local_manifests/

# sync repo
repo sync -c -j"$(nproc --all)" --force-sync --no-clone-bundle --no-tags

# run actual build
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_s88pro-eng
mka -j$(nproc --all) recoveryimage

# copy image to output dir
cp -v out/product/s88pro/recovery.img /var/tmp/buildtwrp/
