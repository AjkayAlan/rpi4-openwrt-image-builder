# rpi4-openwrt-image-builder

Build an OpenWrt image for a Raspberry Pi 4 with the [image builder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder)

## Overview

This builds a super basic OpenWrt image intended to be used in a Raspberry Pi 4 Model B with a TP-Link UE300 USB 3 To Gigabit Ethernet Network Adapter. It builds from the latest OpenWrt snapshots, and overall adds the following packages on top of the base snapshot:

* luci (Main OpenWrt web interface)
* luci-app-sqm (QoS including cake in Luci)
* luci-app-upnp (UPnP in Luci)
* kmod-usb-net-rtl8152 (UE300 USB Driver)
* htop

## Getting The Image

Grab the images by going to the Actions tab, clicking on the latest successful run, and then downloading the Artifacts

## Flashing It

### Already Running OpenWrt On An RPI

If you already have an RPI image flashed to an SD card, you should be able to use the sysupgrade images directly.

### Starting From Scratch

If you don't, you will need a way to flash either ext4 or squashfs. For my Raspberry Pi, I used Linux (specifically, Manjaro), and went with ext4. First, extract the compiled image:

```sh
cd bin/targets/bcm27xx/bcm2711
gzip -d openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img.gz
```

Then, flash it to your SD card (remember to update the below script to match where your card is mounted):

```sh
dd if=openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img of=/dev/sdb bs=2M conv=fsync
```

## Running It

Now that you have flashed the MicroSD card, put it in your Pi. Plug your LAN ethernet into the built in ethernet port, and your WAN ethernet into the USB adapter. After booting, collect to [luci](http://192.168.1.1)

### Interface Setup

You will notice right now you don't have no internet. No worries, lets fix that. Go to Network -> Interfaces. Click `Add new interface`. Use the following settings (assuming you are using DHCP which many Cable providers use, adjust for PPPoE as necessary):

* Name: wan
* Protocol: DHCP Client
* Interface: Eth1

Save, then Save & Apply. You should get an IP! If you have IPv6 via DHCP as well, repeat the same steps with the following:

* Name: wan6
* Protocol: DHCPv6 Client
* Interface: Eth1

### Getting Gigabit Speeds

Shoutout to the hard work of [dlakelan](https://forum.openwrt.org/t/rpi4-routing-performance-numbers/53996/2). Just running this allows me to get ~910Mbps down from LAN (Server) -> Router -> Internet Speed Test Server:

```sh
echo 2 > /sys/class/net/eth1/queues/rx-0/rps_cpus
echo 1 > /sys/class/net/eth0/queues/rx-0/rps_cpus
```

## TODO's

Make a config YAML and use it
Flatten out artifact, too many levels
Publish via releases