# rpi4-openwrt-image-builder

Build an OpenWrt image for a Raspberry Pi 4 with the [image builder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder)

## Overview

This builds a super basic OpenWrt image intended to be used in a Raspberry Pi 4 Model B with a TP-Link UE300 USB 3 To Gigabit Ethernet Network Adapter. It builds from the latest OpenWrt snapshots, and overall adds the following packages ontop of the base snapshot:

* luci (Main OpenWrt web interface)
* luci-app-sqm (QoS including cake in Luci)
* luci-app-upnp (UPnP in Luci)
* kmod-usb-net-rtl8152 (UE300 USB Driver)
* htop
