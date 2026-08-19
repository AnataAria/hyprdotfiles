local config = require("lua.config")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("GTK_THEME", "Dracula")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QML2_IMPORT_PATH", config.paths.quickshell)
hl.env("XCURSOR_SIZE", "32")

hl.env("SDL_VIDEODRIVER", "wayland")

hl.env("HYPRLAND_NO_SD_NOTIFY", "1")
