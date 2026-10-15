#!/bin/bash

icon="$HOME/.config/swaync/icons/dropper.png"
notification_timeout=3000

notify_user() {
    local color="$1"
    notify-send -e -t "$notification_timeout" -u low -i "$icon" "Color picked: $color"
}

pick_color() {
    hyprpicker -a -f hex | tr -d '\n'
}

main() {
    local color
    color=$(pick_color)

    if [ -z "$color" ]; then
        notify-send -e -t "$notification_timeout" -u low -i "$icon" "No color picked."
        exit 1
    fi

    if command -v wl-copy >/dev/null 2>&1; then
        printf '%s' "$color" | wl-copy
    fi

    notify_user "$color"
}

main
