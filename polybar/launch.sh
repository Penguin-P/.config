#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the progress have been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar mybar &

echo "Polybar launched..."



