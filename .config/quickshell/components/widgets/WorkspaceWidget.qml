import QtQuick
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: workspaceButton

    property var config
    property var popupLoader

    implicitWidth: workspaceLabel.width + 32
    implicitHeight: parent.height
    color: "#fda4af"
    radius: workspaceButton.config.metrics.radiusSmall

    Text {
        id: workspaceLabel
        anchors.centerIn: parent
        text: "Workspace " + (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace ? Hyprland.focusedMonitor.activeWorkspace.id : "1")
        font.family: workspaceButton.config.fontFamily
        font.pixelSize: workspaceButton.config.metrics.fontMedium
        font.weight: Font.Medium
        color: "#18181b"
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (workspaceButton.popupLoader) {
                workspaceButton.popupLoader.loading = !workspaceButton.popupLoader.loading;
            }
        }

        hoverEnabled: true
        onEntered: parent.color = "#fb7185"
        onExited: parent.color = "#fda4af"
    }

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }
}
