hl.window_rule({
    name = "generic-dialogs",
    match = {
        title = "^(Open File|Save File|Select a File|Choose Files?).*$",
    },

    float = true,
    center = true,
    size = "900 600",
})

hl.window_rule({
    name = "authentication-dialogs",
    match = {
        class = "^(polkit-gnome-authentication-agent-1|org.freedesktop.impl.portal.desktop.*)$",
    },

    float = true,
    center = true,
    stay_focused = true,
})


hl.window_rule({
    name = "pavucontrol-floating",
    match = {
        class = "^(org.pulseaudio.pavucontrol|pavucontrol)$",
    },

    float = true,
    center = true,
    size = "900 600",
})

hl.window_rule({
    name = "blueman-floating",
    match = {
        class = "^(blueman-manager)$",
    },

    float = true,
    center = true,
    size = "800 600",
})

hl.window_rule({
    name = "calculator-floating",
    match = {
        class = "^(galculator|org.gnome.Calculator)$",
    },

    float = true,
    center = true,
    size = "480 620",
})

hl.window_rule({
    name = "gparted-floating",
    match = {
        class = "^(gpartedbin|gparted)$",
    },

    float = true,
    center = true,
})

hl.window_rule({
    name = "nwgbar-floating",
    match = {
        class = "^(nwgbar)$",
    },

    float = true,
    center = true,
})

hl.window_rule({
    name = "picture-in-picture",
    match = {
        title = "^(Picture-in-Picture|Picture in picture)$",
    },

    float = true,
    pin = true,
    keep_aspect_ratio = true,
    size = "480 270",
    move = "100%-500 30",
})

hl.window_rule({
    name = "thunar-opacity",
    match = {
        class = "^(thunar|Thunar)$",
    },

    opacity = "0.95 override 0.90 override",
})

hl.window_rule({
    name = "terminal-opacity",
    match = {
        class = "^(org.wezfurlong.wezterm|wezterm|foot)$",
    },

    opacity = "0.96 override 0.92 override",
})

-- JetBrains popups/dialogs.
hl.window_rule({
    name = "jetbrains-dialogs",
    match = {
        class = "^(jetbrains-.*)$",
        title = "^(win.*|.*Dialog.*|.*Settings.*)$",
    },

    float = true,
    center = true,
})

-- Prevent selected temporary JetBrains windows from stealing focus.
hl.window_rule({
    name = "jetbrains-no-initial-focus",
    match = {
        class = "^(jetbrains-.*)$",
        title = "^(win.*)$",
    },

    no_initial_focus = true,
})

hl.window_rule({
    name = "browser-workspace",
    match = {
        class = "^(firefox|firefox-developer-edition)$",
    },

    workspace = "2 silent",
})

hl.window_rule({
    name = "mail-workspace",
    match = {
        class = "^(thunderbird)$",
    },

    workspace = "3 silent",
})

hl.window_rule({
    name = "code-workspace",
    match = {
        class = "^(code|Code|code-oss|VSCodium)$",
    },

    workspace = "4 silent",
})

hl.window_rule({
    name = "github-workspace",
    match = {
        class = "^(GitHub Desktop|github-desktop)$",
    },

    workspace = "5 silent",
})