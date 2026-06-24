local config = require("lua.config")

local mod = config.vars.mod

for workspace = 1, 10 do
    local key = tostring(workspace % 10)
    local target = tostring(workspace)

    -- Switch workspace.
    hl.bind(
        mod .. " + " .. key,
        hl.dsp.focus({
            workspace = target,
        }),
        {
            description = "Workspace " .. target,
        }
    )

    -- Move window and follow it.
    hl.bind(
        "ALT + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = target,
            follow = true,
        })
    )

    -- Move window silently.
    hl.bind(
        mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = target,
            follow = false,
        })
    )
end

hl.bind(
    "ALT + SHIFT + J",
    hl.dsp.focus({ workspace = "e-1" })
)

hl.bind(
    "ALT + SHIFT + L",
    hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
    mod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
    mod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" })
)