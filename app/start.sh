#!/bin/bash

# using electron-prebuilt module instead of the global electron let's you
# easily control specific version dependency between your app and electron itself.
# the syntax below starts an X istance with ONLY our electronJS fired up,
# it saves you a LOT of resources avoiding full-desktops envs

while true; do
    rm /tmp/.X0-lock &>/dev/null || true
    if [ ! -c /dev/fb1 ]; then
      modprobe spi-bcm2708 || true
      modprobe fbtft_device name=pitft verbose=0 rotate=$TFT_ROTATE || true

      sleep 1

      mknod /dev/fb1 c $(cat /sys/class/graphics/fb1/dev | tr ':' ' ') || true
    fi
    FRAMEBUFFER=/dev/fb1 startx /usr/src/app/node_modules/electron-prebuilt/dist/electron /usr/src/app --enable-logging
done
