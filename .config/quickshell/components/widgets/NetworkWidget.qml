import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
    id: networkWidget

    property var config
    property string connectionType: "disconnected"
    property string ssid: ""
    property var wifiPanel

    color: "transparent"
    radius: 4
    implicitWidth: networkRow.implicitWidth + 12
    implicitHeight: networkRow.implicitHeight + 8

    Row {
        id: networkRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            id: networkIcon
            font.family: networkWidget.config.fontFamily
            font.pixelSize: 20
            color: networkWidget.connectionType === "disconnected" ? networkWidget.config.colors.fgDim : networkWidget.config.colors.info
            text: "󰤮"
        }

        Text {
            id: networkText
            font.family: networkWidget.config.fontFamilyMono
            font.pixelSize: networkWidget.config.metrics.fontSmall
            font.weight: Font.Bold
            color: networkWidget.config.colors.fg
            visible: networkWidget.ssid !== ""
            text: networkWidget.ssid
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (networkWidget.wifiPanel) {
                networkWidget.wifiPanel.loading = !networkWidget.wifiPanel.loading;
            }
        }
    }

    Component.onCompleted: {
        networkProc.running = true;
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: networkProc.running = true
    }

    Process {
        id: networkProc
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE,CONNECTION device status | grep 'connected' | head -n1"]

        stdout: SplitParser {
            onRead: data => {
                var line = data.trim();
                if (line === "") {
                    networkWidget.connectionType = "disconnected";
                    networkIcon.text = "󰤮";
                    networkWidget.ssid = "";
                    return;
                }

                var parts = line.split(':');
                if (parts.length >= 3) {
                    var type = parts[0];
                    networkWidget.connectionType = type;
                    var connection = parts[2];

                    if (type === "wifi" || type === "wireless") {
                        networkIcon.text = "󰤨";
                        networkWidget.ssid = connection.length > 12 ? connection.substring(0, 12) + "..." : connection;
                    } else if (type === "ethernet") {
                        networkIcon.text = "󰈀";
                        networkWidget.ssid = "Wired";
                    } else {
                        networkIcon.text = "󰛳";
                        networkWidget.ssid = connection;
                    }
                }
            }
        }
    }
}
