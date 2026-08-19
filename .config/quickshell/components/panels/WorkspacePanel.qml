import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: workspacePanel

    property var config
    property bool loading: false
    property var screen

    readonly property var liveWorkspaces: {
        var result = [];

        if (Hyprland.workspaces) {
            for (var i = 0; i < Hyprland.workspaces.length; i++) {
                var workspace = Hyprland.workspaces[i];
                if (!workspace || workspace.id <= 0)
                    continue;

                var hasWindows = workspace.windows && workspace.windows.length > 0;
                if (workspace.active || workspace.focused || hasWindows)
                    result.push(workspace);
            }
        }

        result.sort(function(a, b) {
            return a.id - b.id;
        });

        return result;
    }

    readonly property int tileSize: workspacePanel.config && workspacePanel.config.metrics ? workspacePanel.config.metrics.fontLarge * 3 : 54
    readonly property int panelPadding: workspacePanel.config && workspacePanel.config.metrics ? workspacePanel.config.metrics.spacingMedium + 2 : 16
    readonly property int panelSpacing: workspacePanel.config && workspacePanel.config.metrics ? workspacePanel.config.metrics.spacingSmall : 10
    readonly property int workspaceColumns: liveWorkspaces.length > 0 ? Math.min(3, liveWorkspaces.length) : 1
    readonly property int workspaceRows: liveWorkspaces.length > 0 ? Math.ceil(liveWorkspaces.length / workspaceColumns) : 1

    anchors {
        left: true
        top: true
    }

    implicitWidth: panelPadding * 2 + (liveWorkspaces.length > 0 ? workspaceColumns * tileSize + (workspaceColumns - 1) * panelSpacing : emptyStateLabel.implicitWidth)
    implicitHeight: panelPadding * 2 + (liveWorkspaces.length > 0 ? workspaceRows * tileSize + (workspaceRows - 1) * panelSpacing : emptyStateLabel.implicitHeight)

    visible: loading

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: workspacePanel.config ? workspacePanel.config.colors.bgCard : "#18181b"
        radius: workspacePanel.config ? workspacePanel.config.metrics.radiusLarge : 12
        border.width: 1
        border.color: workspacePanel.config ? workspacePanel.config.colors.bgHighlight : "#3f3f46"

        Item {
            anchors {
                fill: parent
                margins: workspacePanel.panelPadding
            }

            Grid {
                anchors.fill: parent
                columns: workspacePanel.workspaceColumns
                spacing: workspacePanel.panelSpacing
                visible: workspacePanel.liveWorkspaces.length > 0

                Repeater {
                    model: workspacePanel.liveWorkspaces

                    delegate: Rectangle {
                        required property var modelData

                        width: workspacePanel.tileSize
                        height: workspacePanel.tileSize

                        property var workspace: modelData
                        property int workspaceId: workspace.id
                        property bool isActive: workspace.active || workspace.focused
                        property bool hasWindows: workspace.windows && workspace.windows.length > 0

                        color: {
                            if (isActive)
                                return workspacePanel.config ? workspacePanel.config.colors.accent : "#f43f5e";
                            if (hasWindows)
                                return workspacePanel.config ? workspacePanel.config.colors.workspaceOccupied : "#71717a";
                            return workspacePanel.config ? workspacePanel.config.colors.workspaceInactive : "#3f3f46";
                        }

                        radius: workspacePanel.config ? workspacePanel.config.metrics.radiusSmall : 6

                        border.width: isActive ? 2 : 0
                        border.color: workspacePanel.config ? workspacePanel.config.colors.accentBright : "#fb7185"

                        Text {
                            anchors.centerIn: parent
                            text: parent.workspaceId
                            font.family: workspacePanel.config ? workspacePanel.config.fontFamilyMono : "monospace"
                            font.pixelSize: workspacePanel.config ? workspacePanel.config.metrics.fontLarge : 18
                            font.weight: parent.isActive ? Font.Bold : Font.Normal
                            color: parent.isActive ? (workspacePanel.config ? workspacePanel.config.colors.bg : "#18181b") : (workspacePanel.config ? workspacePanel.config.colors.fg : "#fafafa")
                        }

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
                                Hyprland.dispatch("workspace " + parent.workspaceId);
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

            Text {
                id: emptyStateLabel
                anchors.centerIn: parent
                visible: workspacePanel.liveWorkspaces.length === 0
                text: "No workspaces"
                font.family: workspacePanel.config ? workspacePanel.config.fontFamilyMono : "monospace"
                font.pixelSize: workspacePanel.config ? workspacePanel.config.metrics.fontLarge : 18
                color: workspacePanel.config ? workspacePanel.config.colors.fgDim : "#a1a1aa"
                opacity: 0.8
            }
        }
    }
}
