
hl.layer_rule({
    name = "waybar-blur",
    match = {
        namespace = "waybar",
    },

    blur = true,
    blur_popups = true,
    ignore_alpha = 0.2,
})

hl.layer_rule({
    name = "wofi-blur",
    match = {
        namespace = "wofi",
    },

    blur = true,
    ignore_alpha = 0.15,
    animation = "popin",
})

hl.layer_rule({
    name = "quickshell-blur",
    match = {
        namespace = "quickshell.*",
    },

    blur = true,
    blur_popups = true,
    ignore_alpha = 0.15,
})

hl.layer_rule({
    name = "mako-animation",
    match = {
        namespace = "notifications",
    },

    animation = "slide",
})

hl.layer_rule({
    name = "selection-no-animation",
    match = {
        namespace = "selection",
    },

    no_anim = true,
})

hl.layer_rule({
    name = "wallpaper-no-animation",
    match = {
        namespace = "awww-daemon",
    },

    no_anim = true,
})