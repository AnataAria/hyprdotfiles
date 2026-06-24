local config = require("lua.config")

local mod = config.vars.mod

hl.bind(
    mod .. " + mouse:272",
    hl.dsp.window.drag(),
    {
        mouse = true,
        description = "Drag window",
    }
)

hl.bind(
    mod .. " + mouse:273",
    hl.dsp.window.resize(),
    {
        mouse = true,
        description = "Resize window",
    }
)

hl.bind(
    mod .. " + R",
    hl.dsp.submap("resize"),
    { description = "Resize mode" }
)

hl.define_submap("resize", function()
    local resize = {
        Right = { x = 50, y = 0 },
        L = { x = 50, y = 0 },

        Left = { x = -50, y = 0 },
        H = { x = -50, y = 0 },

        Up = { x = 0, y = -50 },
        K = { x = 0, y = -50 },

        Down = { x = 0, y = 50 },
        J = { x = 0, y = 50 },
    }

    for key, size in pairs(resize) do
        hl.bind(
            key,
            hl.dsp.window.resize({
                x = size.x,
                y = size.y,
                relative = true,
            }),
            { repeating = true }
        )
    end

    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
end)