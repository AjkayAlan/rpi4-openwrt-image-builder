#!/bin/bash

cd target/openwrt-imagebuilder-bcm27xx-bcm2711.Linux-x86_64
make image PROFILE=rpi-4 PACKAGES="luci luci-app-sqm luci-app-upnp kmod-usb-net-rtl8152 htop"
