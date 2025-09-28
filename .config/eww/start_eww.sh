#!/bin/bash

# Function to get monitor IDs from Hyprland
get_monitor_ids() {
    hyprctl monitors | grep -oP "ID \K\d+"
}

# Function to start the Eww daemon
start_eww_daemon() {
    if ! pgrep -x "eww" > /dev/null; then
        echo "Starting Eww daemon..."
        eww daemon
    fi
}

# Function to open the bar on all monitors
open_eww_bar() {
    start_eww_daemon

    local MONITOR_IDS=$(get_monitor_ids)
    for ID in $MONITOR_IDS; do
        echo "Opening bar on screen $ID..."
        eww open bar --screen "$ID" --id "screen-$ID"
    done
}

# Function to close the bar on all monitors
close_eww_bar() {
    local MONITOR_IDS=$(get_monitor_ids)
    for ID in $MONITOR_IDS; do
        echo "Closing bar on screen $ID..."
        eww close "screen-$ID"
    done
}

# Main logic for the script
case "$1" in
    open)
        open_eww_bar
        ;;
    close)
        close_eww_bar
        ;;
    *)
        echo "Usage: $0 {open|close}"
        exit 1
        ;;
esac
