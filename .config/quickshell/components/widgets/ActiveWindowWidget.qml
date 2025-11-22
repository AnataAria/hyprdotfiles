import QtQuick
import Quickshell
import Quickshell.Hyprland

Text {
    id: activeWindowWidget

    property var config
    property string activeWindowClass: "desktop"
    property int maxLength: 30

    text: activeWindowClass.length > maxLength ? activeWindowClass.substring(0, maxLength) + "..." : activeWindowClass

    font.family: config.fontFamily
    font.pixelSize: config.metrics.fontSmall
    color: config.colors.fgDim

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activewindow") {
                var parts = event.data.split(",");

                if (parts.length >= 2 && parts[1]) {
                    activeWindowWidget.activeWindowClass = parts[1].toLowerCase();
                } else {
                    activeWindowWidget.activeWindowClass = "desktop";
                }
            }
        }
    }
}
