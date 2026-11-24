local config = require("lua.config")

local mod = config.vars.mod


hl.bind(
    mod .. " + V",
    hl.dsp.exec_cmd(
        "cliphist list | wofi --dmenu | " ..
        "cliphist decode | wl-copy"
    ),
    { description = "Clipboard history" }
)