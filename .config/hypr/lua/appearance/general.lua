local config = require("lua.config")

hl.config({
    general = {
        gaps_in = config.vars.gaps.inner,
        gaps_out = config.vars.gaps.outer,
        border_size = config.vars.border_size,

        ["col.active_border"] = config.vars.colors.active_border,
        ["col.inactive_border"] = config.vars.colors.inactive_border,

        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
    },
})