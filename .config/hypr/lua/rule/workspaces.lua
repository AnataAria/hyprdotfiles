local workspaces = {
    { id = 1, monitor = "eDP-1", default = true },
    { id = 2, monitor = "HDMI-A-1", default = true },
}

for _, ws in ipairs(workspaces) do
    hl.workspace_rule({
        workspace = tostring(ws.id),
        monitor = ws.monitor,
        default = ws.default or false,
        layout = "dwindle",
    })
end
