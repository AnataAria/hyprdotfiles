local config = require("lua.config")

local mod = config.vars.mod

hl.bind(
    mod .. " + Q",
    hl.dsp.window.close(),
    { description = "Close active window" }
)

hl.bind(
    mod .. " + SHIFT + code:65",
    hl.dsp.window.float(),
    { description = "Toggle floating" }
)

hl.bind(
    mod .. " + P",
    hl.dsp.window.pseudo(),
    { description = "Toggle pseudotile" }
)

hl.bind(
    mod .. " + D",
    hl.dsp.window.fullscreen(),
    { description = "Toggle fullscreen" }
)

local focus_directions = {
    H = "l",
    J = "d",
    K = "u",
    L = "r",
    Left = "l",
    Down = "d",
    Up = "u",
    Right = "r",
}

for key, direction in pairs(focus_directions) do
    hl.bind(
        mod .. " + " .. key,
        hl.dsp.focus({ direction = direction })
    )
end

local move_directions = {
    H = "l",
    J = "d",
    K = "u",
    L = "r",
    Left = "l",
    Down = "d",
    Up = "u",
    Right = "r",
}

for key, direction in pairs(move_directions) do
    hl.bind(
        mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            direction = direction,
        })
    )
end