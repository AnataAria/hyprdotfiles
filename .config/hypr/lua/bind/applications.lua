local config = require("lua.config")

local mod = config.vars.mod
local apps = config.apps

hl.bind(
    mod .. " + T",
    hl.dsp.exec_cmd(apps.terminal),
    { description = "Open terminal" }
)

hl.bind(
    mod .. " + code:36",
    hl.dsp.exec_cmd(apps.terminal),
    { description = "Open terminal" }
)

hl.bind(
    mod .. " + F",
    hl.dsp.exec_cmd(apps.launcher),
    { description = "Application launcher" }
)

hl.bind(
    mod .. " + N",
    hl.dsp.exec_cmd(apps.file_manager),
    { description = "File manager" }
)

hl.bind(
    mod .. " + SHIFT + E",
    hl.dsp.exec_cmd(apps.power_menu),
    { description = "Power menu" }
)

hl.bind(
    mod .. " + SHIFT + Q",
    hl.dsp.exec_cmd(apps.lock),
    { description = "Lock session" }
)

hl.bind(
    mod .. " + F1",
    hl.dsp.exec_cmd(apps.browser)
)

hl.bind(
    mod .. " + F2",
    hl.dsp.exec_cmd(apps.mail)
)

hl.bind(
    mod .. " + F3",
    hl.dsp.exec_cmd(apps.file_manager)
)

local function_applications = {
    F4 = "geany",
    F5 = "github-desktop",
    F6 = "gparted",
    F7 = "inkscape",
    F8 = "blender",
    F9 = "meld",
    F10 = "joplin-desktop",
    F11 = "snapper-tools",
    F12 = "galculator",
}

for key, command in pairs(function_applications) do
    hl.bind(mod .. " + " .. key, hl.dsp.exec_cmd(command))
end

hl.bind(
    mod .. " + B",
    hl.dsp.exec_cmd(
        "bash " ..
        config.paths.config ..
        "/swww/start.sh change_bg"
    ),
    { description = "Change wallpaper" }
)

hl.bind(
    mod .. " + I",
    hl.dsp.exec_cmd(
        config.paths.scripts .. "/toggle-quickshell.sh"
    ),
    { description = "Toggle Quickshell" }
)

hl.bind(
    mod .. " + V",
    hl.dsp.exec_cmd(
        "cliphist list | wofi --dmenu | " ..
        "cliphist decode | wl-copy"
    ),
    { description = "Clipboard history" }
)