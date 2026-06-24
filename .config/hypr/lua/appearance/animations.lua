-- ~/.config/hypr/lua/appearance/animations.lua

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutBack", {
    type = "bezier",
    points = {
        { 0.34, 1.56 },
        { 0.64, 1.00 },
    },
})

hl.curve("easeInOut", {
    type = "bezier",
    points = {
        { 0.42, 0.00 },
        { 0.58, 1.00 },
    },
})

hl.curve("easeOut", {
    type = "bezier",
    points = {
        { 0.00, 0.00 },
        { 0.20, 1.00 },
    },
})

hl.curve("easeIn", {
    type = "bezier",
    points = {
        { 0.40, 0.00 },
        { 1.00, 1.00 },
    },
})

hl.curve("linear", {
    type = "bezier",
    points = {
        { 0.00, 0.00 },
        { 1.00, 1.00 },
    },
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4,
    bezier = "easeInOut",
    style = "slide",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutBack",
    style = "slide",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3,
    bezier = "easeOut",
    style = "slide",
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 3,
    bezier = "easeInOut",
    style = "slide",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 1,
    bezier = "easeInOut",
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 30,
    bezier = "linear",
    style = "loop",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 8,
    bezier = "easeOut",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "easeOut",
})