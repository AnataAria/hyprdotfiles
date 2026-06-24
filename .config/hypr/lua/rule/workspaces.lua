for workspace = 1, 10 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        persistent = true,
    })
end


hl.workspace_rule({
    workspace = "1",
    default_name = "terminal",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "2",
    default_name = "web",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "3",
    default_name = "communication",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "4",
    default_name = "code",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "5",
    default_name = "tools",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "6",
    default_name = "design",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "7",
    default_name = "lab",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "8",
    default_name = "monitoring",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "9",
    default_name = "temporary",
    layout = "dwindle",
})

hl.workspace_rule({
    workspace = "10",
    default_name = "misc",
    layout = "dwindle",
})

-- Laptop monitor.
hl.workspace_rule({
    workspace = "1",
    monitor = "eDP-2",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "eDP-2",
})

hl.workspace_rule({
    workspace = "3",
    monitor = "eDP-2",
})

hl.workspace_rule({
    workspace = "4",
    monitor = "eDP-2",
})

hl.workspace_rule({
    workspace = "5",
    monitor = "eDP-2",
})

hl.workspace_rule({
    workspace = "6",
    monitor = "HDMI-A-1",
    default = true,
})

hl.workspace_rule({
    workspace = "7",
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = "8",
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = "9",
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = "10",
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = "special:scratchpad",
    gaps_in = 10,
    gaps_out = 20,
    border_size = 2,
})