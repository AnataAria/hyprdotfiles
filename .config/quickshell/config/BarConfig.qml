import QtQuick
import Quickshell.Hyprland
import "../theme"

QtObject {
    id: config

    // Read Hyprland monitor scale
    readonly property var hyprlandMonitor: Hyprland.focusedMonitor
    readonly property real hyprlandScale: hyprlandMonitor && hyprlandMonitor.scale ? hyprlandMonitor.scale : 1.0

    property Colors colors: Colors {}
    property Metrics metrics: Metrics {
        scaleFactor: config.hyprlandScale
    }

    readonly property string position: "top"

    readonly property bool autoHide: false
    readonly property int hideDelay: 1000

    readonly property bool showWorkspaces: true
    readonly property bool showClock: true
    readonly property bool showSystemMonitor: true
    readonly property bool showBattery: true
    readonly property bool showNetwork: true
    readonly property bool showAudio: true
    readonly property bool showNotifications: false

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property string fontFamilyMono: "JetBrainsMono Nerd Font Mono"
}
