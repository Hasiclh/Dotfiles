#!/bin/bash

# set up the two monitors for bspwm
# NOTE This is a simplistic approach because I already know the settings I
# want to apply.
my_laptop_external_monitor=$(xrandr --query | grep 'HDMI-2')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    xrandr --output eDP-1 --primary --mode 1920x1080 --rotate normal --output HDMI-2 --mode 2560x1080 --rotate normal --left-of eDP-1
fi