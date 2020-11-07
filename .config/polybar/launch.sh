#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar example &

my_laptop_external_monitor=$(xrandr --query | grep 'HDMI-2')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar example-external &
fi