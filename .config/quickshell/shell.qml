import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "./config"
import "./components/widgets"
import "./components/panels"
import "./components/windows"

ShellRoot {
    BarConfig {
        id: barConfig
    }

    Instantiator {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: barWindow
            required property var modelData
            required property int index

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: barConfig.metrics.barHeight + (barConfig.metrics.barMargin * 2)
            exclusiveZone: implicitHeight

            color: "transparent"

            Rectangle {
                anchors {
                    fill: parent
                    topMargin: barConfig.metrics.barMargin
                    bottomMargin: barConfig.metrics.barMargin
                    leftMargin: barConfig.metrics.barMargin
                    rightMargin: barConfig.metrics.barMargin
                }
                color: barConfig.colors.bgCard
                radius: barConfig.metrics.radiusMedium

                WorkspaceWidget {
                    id: workspaceBtn
                    config: barConfig
                    popupLoader: workspacePopupLoader
                    barScreen: barWindow.screen
                    visible: barConfig.showWorkspaces
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                }

                ActiveWindowWidget {
                    id: activeWindowBtn
                    config: barConfig
                    visible: true
                    anchors {
                        left: workspaceBtn.right
                        leftMargin: barConfig.metrics.spacingLarge
                        verticalCenter: parent.verticalCenter
                    }
                }

                ClockWidget {
                    config: barConfig
                    visible: barConfig.showClock
                    anchors.centerIn: parent
                }

                Row {
                    anchors {
                        right: parent.right
                        rightMargin: barConfig.metrics.barPaddingH
                        verticalCenter: parent.verticalCenter
                    }
                    spacing: barConfig.metrics.spacingLarge

                    NetworkWidget {
                        config: barConfig
                        visible: barConfig.showNetwork
                        wifiPanel: wifiPanelLoader
                        barScreen: barWindow.screen
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    AudioWidget {
                        config: barConfig
                        visible: barConfig.showAudio
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        width: 1
                        height: 18
                        color: barConfig.colors.fgDim
                        opacity: 0.2
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SystemMonitorWidget {
                        config: barConfig
                        visible: barConfig.showSystemMonitor
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    DateButton {
                        config: barConfig
                        settingsPanel: profilePanelLoader
                        barScreen: barWindow.screen
                    }
                }
            }
        }
    }

    WorkspacePanel {
        id: workspacePopupLoader
        config: barConfig
    }

    ProfilePanel {
        id: profilePanelLoader
        config: barConfig
        settingsWindow: settingsWindowLoader
    }

    SettingsWindow {
        id: settingsWindowLoader
        config: barConfig
    }

    WiFiPanel {
        id: wifiPanelLoader
        config: barConfig
    }
}
