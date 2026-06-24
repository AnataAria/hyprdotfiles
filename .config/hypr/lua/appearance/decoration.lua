local config = require("lua.config")

hl.config({
    decoration = {
        rounding = config.vars.rounding,

        blur = {
            enabled = true,
            size = 5,
            passes = 1,
        },

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = config.vars.colors.shadow,
        },
    },
})
