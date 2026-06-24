hl.monitor({
    output = "eDP-2",
    mode = "2560x1600@165.004",
    position = "0x1080",
    scale = 1.25,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "60x0",
    scale = 1,
})

-- Fallback for unknown monitors.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})