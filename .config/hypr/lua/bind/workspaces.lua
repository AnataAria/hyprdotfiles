local config = require("lua.config")

local mod = config.vars.mod

for workspace = 1, 10 do
    local key = tostring(workspace % 10)
    local target = tostring(workspace)

    hl.bind(
        mod .. " + " .. key,
        hl.dsp.focus({ workspace = target }),
        {
            description = "Workspace " .. target,
        }
    )

    hl.bind(
        mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = target,
            follow = true,
        }),
        {
            description = "Move to workspace " .. target,
        }
    )

    hl.bind(
        mod .. " + CTRL + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = target,
            follow = false,
        }),
        {
            description = "Move silently to workspace " .. target,
        }
    )
end

hl.bind(
    "ALT + SHIFT + J",
    hl.dsp.focus({ workspace = "-1" })
)

hl.bind(
    "ALT + SHIFT + L",
    hl.dsp.focus({ workspace = "+1" })
)

hl.bind(
    mod .. " + mouse_down",
    hl.dsp.focus({ workspace = "+1" })
)

hl.bind(
    mod .. " + mouse_up",
    hl.dsp.focus({ workspace = "-1" })
)