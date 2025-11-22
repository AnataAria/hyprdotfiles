import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: workspacePanel

    property var config
    property bool loading: false

    anchors {
        left: true
        top: true
    }

    implicitWidth: 280
    implicitHeight: 220

    visible: loading

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: workspacePanel.config.colors.bgCard
        radius: workspacePanel.config.metrics.radiusLarge
        border.width: 1
        border.color: workspacePanel.config.colors.bgHighlight

        // 3x3 Grid layout
        Grid {
            anchors {
                fill: parent
                margins: 16
            }
            columns: 3
            rows: 3
            spacing: 10

            Repeater {
                model: 9

                delegate: Rectangle {
                    required property int index

                    width: (parent.width - (parent.spacing * 2)) / 3
                    height: (parent.height - (parent.spacing * 2)) / 3

                    property int workspaceId: index + 1
                    property bool isActive: Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace && Hyprland.focusedMonitor.activeWorkspace.id === workspaceId
                    property bool hasWindows: {
                        for (var i = 0; i < Hyprland.workspaces.length; i++) {
                            if (Hyprland.workspaces[i].id === workspaceId) {
                                return Hyprland.workspaces[i].windows && Hyprland.workspaces[i].windows.length > 0;
                            }
                        }
                        return false;
                    }

                    color: {
                        if (isActive)
                            return workspacePanel.config.colors.accent;
                        if (hasWindows)
                            return workspacePanel.config.colors.workspaceOccupied;
                        return workspacePanel.config.colors.workspaceInactive;
                    }

                    radius: workspacePanel.config.metrics.radiusSmall

                    border.width: isActive ? 2 : 0
                    border.color: workspacePanel.config.colors.accentBright

                    // Workspace number
                    Text {
                        anchors.centerIn: parent
                        text: parent.workspaceId
                        font.family: workspacePanel.config.fontFamilyMono
                        font.pixelSize: workspacePanel.config.metrics.fontLarge
                        font.weight: parent.isActive ? Font.Bold : Font.Normal
                        color: parent.isActive ? workspacePanel.config.colors.bg : workspacePanel.config.colors.fg
                    }

                    // Hover effect
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: {
                            parent.scale = 0.95;
                            parent.opacity = 0.8;
                        }

                        onExited: {
                            parent.scale = 1.0;
                            parent.opacity = 1.0;
                        }

                        onClicked: {
                            var wsId = parent.workspaceId;
                            console.log("Switching to workspace " + wsId);
                            Hyprland.dispatch("workspace " + wsId);
                            // Close popup after switching
                            workspacePanel.loading = false;
                        }
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
            }
        }
    }
}
