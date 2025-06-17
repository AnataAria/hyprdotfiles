#!/bin/bash

init_swww() {
  if ! swww query &>/dev/null; then
    echo "Initializing swww..."
    swww-daemon
  fi
}

change_wallpaper_random() {
  init_swww
  # Directory containing images
  IMAGE_DIR="$HOME/.config/swww/backgrounds"

  # Check if the directory exists and contains files
  if [ ! -d "$IMAGE_DIR" ] || [ -z "$(ls -A "$IMAGE_DIR")" ]; then
    echo "Error: Image directory is empty or does not exist."
    exit 1
  fi

  # Select a random image
  IMG=$(find "$IMAGE_DIR" -type f | shuf -n 1)

  # Apply the wallpaper
  echo "Changing wallpaper to $IMG"
  swww img --transition-type outer --transition-step 2 --transition-pos 0,0 --transition-fps 120 "$IMG"
}
wallpaper_slideshow() {
  init_swww
  # Interval in seconds between wallpaper changes
  INTERVAL=600

  # Directory containing images
  IMAGE_DIR="$HOME/.config/swww/backgrounds"

  # Check if the directory exists and contains files
  if [ ! -d "$IMAGE_DIR" ] || [ -z "$(ls -A "$IMAGE_DIR")" ]; then
    echo "Error: Image directory is empty or does not exist."
    exit 1
  fi

  # Infinite loop to continuously change wallpapers
  while true; do
    find "$IMAGE_DIR" -type f |
      shuf |
      while read -r img; do
        echo "Changing wallpaper to $img"
        swww img --transition-type outer --transition-step 2 --transition-pos 0,0 --transition-fps 120 "$img"
        sleep $INTERVAL
      done
  done
}

case "$1" in
slideshow)
  wallpaper_slideshow
  ;;
change_bg)
  change_wallpaper_random
  ;;
*)
  echo "Usage: $0 {slideshow|change_bg}"
  exit 1
  ;;
esac
