#!/usr/bin/env bash

dir="$HOME/Pictures/screenshots"
mkdir -p "$dir"

file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

grim -g "$(slurp)" - | tee "$file" | wl-copy
