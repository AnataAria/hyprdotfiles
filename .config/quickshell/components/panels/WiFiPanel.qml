import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

PanelWindow {
    id: wifiPanel

    property var config
    property bool loading: false
    property string selectedSsid: ""
    property bool showPasswordInput: false

    anchors {
        right: true
        top: true
    }

    margins {
        right: 10
        top: 60
    }

    implicitWidth: 350
    implicitHeight: 500
    visible: loading

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: wifiPanel.config.colors.bgCard
        radius: wifiPanel.config.metrics.radiusLarge
        border.width: 1
        border.color: wifiPanel.config.colors.bgHighlight

        Column {
            anchors.fill: parent
            spacing: 0

            // Header
            Item {
                width: parent.width
                height: 60

                Row {
                    anchors {
                        left: parent.left
                        leftMargin: 20
                        verticalCenter: parent.verticalCenter
                    }
                    spacing: 12

                    Text {
                        text: "󰖩"
                        font.family: wifiPanel.config.fontFamily
                        font.pixelSize: 24
                        color: wifiPanel.config.colors.info
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: "WiFi Networks"
                        font.family: wifiPanel.config.fontFamily
                        font.pixelSize: wifiPanel.config.metrics.fontLarge
                        font.weight: Font.Bold
                        color: wifiPanel.config.colors.fg
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                // Refresh button
                Rectangle {
                    anchors {
                        right: parent.right
                        rightMargin: 20
                        verticalCenter: parent.verticalCenter
                    }
                    width: 36
                    height: 36
                    radius: 18
                    color: refreshMouseArea.containsMouse ? wifiPanel.config.colors.bgCardHover : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: ""
                        font.family: wifiPanel.config.fontFamily
                        font.pixelSize: 18
                        color: wifiPanel.config.colors.fg
                    }

                    MouseArea {
                        id: refreshMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: scanWifiProc.running = true
                    }
                }
            }

            Rectangle {
                width: parent.width - 40
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                color: wifiPanel.config.colors.fgDim
                opacity: 0.3
            }

            // WiFi List or Password Input
            Item {
                width: parent.width
                height: parent.height - 61

                // WiFi Networks List
                Flickable {
                    id: wifiListView
                    anchors.fill: parent
                    contentHeight: wifiListColumn.height
                    clip: true
                    visible: !showPasswordInput

                    Column {
                        id: wifiListColumn
                        width: parent.width
                        spacing: 0

                        Repeater {
                            id: networkRepeater
                            model: ListModel {
                                id: networksModel
                            }

                            delegate: Rectangle {
                                width: wifiListColumn.width
                                height: 70
                                color: networkMouseArea.containsMouse ? wifiPanel.config.colors.bgCardHover : "transparent"

                                Row {
                                    anchors {
                                        left: parent.left
                                        leftMargin: 20
                                        right: parent.right
                                        rightMargin: 20
                                        verticalCenter: parent.verticalCenter
                                    }
                                    spacing: 16

                                    Text {
                                        text: model.signal > 75 ? "󰤨" : model.signal > 50 ? "󰤥" : model.signal > 25 ? "󰤢" : "󰤟"
                                        font.family: wifiPanel.config.fontFamily
                                        font.pixelSize: 20
                                        color: wifiPanel.config.colors.info
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Column {
                                        anchors.verticalCenter: parent.verticalCenter
                                        spacing: 4
                                        width: parent.width - 80

                                        Text {
                                            text: model.ssid
                                            font.family: wifiPanel.config.fontFamily
                                            font.pixelSize: wifiPanel.config.metrics.fontMedium
                                            font.weight: Font.Medium
                                            color: wifiPanel.config.colors.fg
                                            elide: Text.ElideRight
                                            width: parent.width
                                        }

                                        Row {
                                            spacing: 8

                                            Text {
                                                text: model.security ? "" : "󰞀"
                                                font.family: wifiPanel.config.fontFamily
                                                font.pixelSize: 12
                                                color: wifiPanel.config.colors.fgDim
                                                visible: text !== ""
                                            }

                                            Text {
                                                text: model.connected ? "Connected" : (model.security ? "Secured" : "Open")
                                                font.family: wifiPanel.config.fontFamily
                                                font.pixelSize: wifiPanel.config.metrics.fontSmall
                                                color: model.connected ? wifiPanel.config.colors.success : wifiPanel.config.colors.fgDim
                                            }
                                        }
                                    }
                                }

                                MouseArea {
                                    id: networkMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        selectedSsid = model.ssid;
                                        if (model.connected) {
                                            console.log("Already connected to:", selectedSsid);
                                        } else if (model.security) {
                                            showPasswordInput = true;
                                        } else {
                                            connectToWifiProc.running = true;
                                        }
                                    }
                                }

                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    width: parent.width - 40
                                    height: 1
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: wifiPanel.config.colors.fgDim
                                    opacity: 0.1
                                }
                            }
                        }

                        Item {
                            width: parent.width
                            height: 20
                        }
                    }
                }

                // Password Input Screen
                Column {
                    anchors {
                        fill: parent
                        margins: 20
                    }
                    spacing: 20
                    visible: showPasswordInput

                    Text {
                        text: "Connect to \"" + selectedSsid + "\""
                        font.family: wifiPanel.config.fontFamily
                        font.pixelSize: wifiPanel.config.metrics.fontMedium
                        font.weight: Font.DemiBold
                        color: wifiPanel.config.colors.fg
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }

                    Column {
                        width: parent.width
                        spacing: 8

                        Text {
                            text: "Password"
                            font.family: wifiPanel.config.fontFamily
                            font.pixelSize: wifiPanel.config.metrics.fontSmall
                            color: wifiPanel.config.colors.fgDim
                        }

                        Rectangle {
                            width: parent.width
                            height: 40
                            radius: wifiPanel.config.metrics.radiusSmall
                            color: wifiPanel.config.colors.bgHighlight
                            border.width: passwordInput.activeFocus ? 2 : 1
                            border.color: passwordInput.activeFocus ? wifiPanel.config.colors.accent : wifiPanel.config.colors.fgDim

                            TextInput {
                                id: passwordInput
                                anchors {
                                    fill: parent
                                    leftMargin: 12
                                    rightMargin: 12
                                }
                                verticalAlignment: TextInput.AlignVCenter
                                font.family: wifiPanel.config.fontFamilyMono
                                font.pixelSize: wifiPanel.config.metrics.fontMedium
                                color: wifiPanel.config.colors.fg
                                echoMode: TextInput.Password
                                selectByMouse: true
                            }
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 12

                        Rectangle {
                            width: (parent.width - 12) / 2
                            height: 40
                            radius: wifiPanel.config.metrics.radiusSmall
                            color: cancelMouseArea.containsMouse ? wifiPanel.config.colors.bgCardHover : wifiPanel.config.colors.bgHighlight

                            Text {
                                anchors.centerIn: parent
                                text: "Cancel"
                                font.family: wifiPanel.config.fontFamily
                                font.pixelSize: wifiPanel.config.metrics.fontMedium
                                color: wifiPanel.config.colors.fg
                            }

                            MouseArea {
                                id: cancelMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    showPasswordInput = false;
                                    passwordInput.text = "";
                                }
                            }
                        }

                        Rectangle {
                            width: (parent.width - 12) / 2
                            height: 40
                            radius: wifiPanel.config.metrics.radiusSmall
                            color: connectMouseArea.containsMouse ? Qt.lighter(wifiPanel.config.colors.info, 1.2) : wifiPanel.config.colors.info

                            Text {
                                anchors.centerIn: parent
                                text: "Connect"
                                font.family: wifiPanel.config.fontFamily
                                font.pixelSize: wifiPanel.config.metrics.fontMedium
                                font.weight: Font.Bold
                                color: wifiPanel.config.colors.bg
                            }

                            MouseArea {
                                id: connectMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    if (passwordInput.text.length >= 8) {
                                        connectToWifiProc.running = true;
                                    }
                                }
                            }
                        }
                    }

                    Text {
                        text: "Note: Password must be at least 8 characters"
                        font.family: wifiPanel.config.fontFamily
                        font.pixelSize: 10
                        color: wifiPanel.config.colors.fgDim
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }

    Process {
        id: scanWifiProc
        command: ["sh", "-c", "nmcli -t -f SSID,SIGNAL,SECURITY,ACTIVE device wifi list"]

        stdout: SplitParser {
            onRead: data => {
                networksModel.clear();
                var lines = data.trim().split('\n');
                for (var i = 0; i < lines.length; i++) {
                    var parts = lines[i].split(':');
                    if (parts.length >= 4 && parts[0]) {
                        networksModel.append({
                            ssid: parts[0],
                            signal: parseInt(parts[1]) || 0,
                            security: parts[2] !== "",
                            connected: parts[3] === "yes"
                        });
                    }
                }
            }
        }
    }

    // Connect to WiFi
    Process {
        id: connectToWifiProc
        command: showPasswordInput && passwordInput.text ? ["sh", "-c", "nmcli device wifi connect '" + selectedSsid + "' password '" + passwordInput.text + "'"] : ["sh", "-c", "nmcli device wifi connect '" + selectedSsid + "'"]

        stdout: SplitParser {
            onRead: data => {
                console.log("WiFi connection:", data);
                showPasswordInput = false;
                passwordInput.text = "";
                scanWifiProc.running = true;
            }
        }
    }

    // Auto-scan on open
    onLoadingChanged: {
        if (loading) {
            scanWifiProc.running = true;
        }
    }
}
