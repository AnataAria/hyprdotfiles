local home = assert(os.getenv("HOME"), "HOME is not set")
local paths = {
    home = home,
    config = home .. "/.config",
    hypr = home .. "/.config/hypr",
    scripts = home .. "/.config/hypr/scripts",
    wallpapers = home .. "/.config/hypr/assets/wallpapers",
    quickshell = home .. "/.config/quickshell",
}

return paths