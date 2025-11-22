import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "./config"
import "./components/widgets"
import "./components/panels"
import "./components/windows"

Item {
    BarConfig {
        id: barConfig
    }

    PanelWindow {
        id: bar

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

                SystemMonitorWidget {
                    config: barConfig
                    visible: barConfig.showSystemMonitor
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    width: 1
                    height: 18
                    color: barConfig.colors.fgDim
                    opacity: 0.2
                    anchors.verticalCenter: parent.verticalCenter
                }

                NetworkWidget {
                    config: barConfig
                    visible: barConfig.showNetwork
                    wifiPanel: wifiPanelLoader
                    anchors.verticalCenter: parent.verticalCenter
                }

                BatteryWidget {
                    config: barConfig
                    visible: barConfig.showBattery
                    anchors.verticalCenter: parent.verticalCenter
                }

                AudioWidget {
                    config: barConfig
                    visible: barConfig.showAudio
                    anchors.verticalCenter: parent.verticalCenter
                }

                DateButton {
                    config: barConfig
                    settingsPanel: profilePanelLoader
                }
            }
        }
    }

    // Workspace popup panel
    WorkspacePanel {
        id: workspacePopupLoader
        config: barConfig
    }

    // Profile panel
    ProfilePanel {
        id: profilePanelLoader
        config: barConfig
        settingsWindow: settingsWindowLoader
    }

    // Settings window
    SettingsWindow {
        id: settingsWindowLoader
        config: barConfig
    }

    // WiFi panel
    WiFiPanel {
        id: wifiPanelLoader
        config: barConfig
    }
}
