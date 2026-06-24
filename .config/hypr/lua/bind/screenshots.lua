local config = require("lua.config")

hl.bind(
    "Print",
    hl.dsp.exec_cmd(
        config.paths.scripts ..
        "/screenshot-selection.sh"
    ),
    { description = "Screenshot selection" }
)

hl.bind(
    "CTRL + Print",
    hl.dsp.exec_cmd(
        config.paths.scripts ..
        "/screenshot-window.sh"
    ),
    { description = "Screenshot window" }
)

hl.bind(
    "SHIFT + Print",
    hl.dsp.exec_cmd(
        config.paths.scripts ..
        "/screenshot-display.sh"
    ),
    { description = "Screenshot display" }
)