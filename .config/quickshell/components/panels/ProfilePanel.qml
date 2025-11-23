import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import "../profile"

PanelWindow {
    id: profilePanel

    property var config
    property bool loading: false
    property var screen
    property var settingsWindow

    readonly property var hyprlandMonitor: Hyprland.focusedMonitor
    readonly property real hyprlandScale: hyprlandMonitor && hyprlandMonitor.scale ? hyprlandMonitor.scale : 1.0
    readonly property real screenWidth: hyprlandMonitor ? hyprlandMonitor.width : 1920
    readonly property real screenHeight: hyprlandMonitor ? hyprlandMonitor.height : 1080

    anchors {
        right: true
        top: true
    }

    margins {
        right: Math.round(10 * hyprlandScale)
        top: Math.round(10 * hyprlandScale)
    }

    implicitWidth: Math.round(Math.min(420, screenWidth * 0.22) * hyprlandScale)
    implicitHeight: Math.round(Math.min(700, screenHeight * 0.65) * hyprlandScale)
    visible: loading

    color: "transparent"

    property bool wifiEnabled: true
    property bool bluetoothEnabled: false
    property bool focusModeEnabled: false
    property bool darkThemeEnabled: true
    property string wifiSsid: "WiFi"
    property real volumeLevel: 0.48
    property real brightnessLevel: 0.89

    onVolumeLevelChanged: {
        if (volumeLevel > 1.0)
            volumeLevel = 1.0;
        if (volumeLevel < 0.0)
            volumeLevel = 0.0;
        volumeSetProc.running = true;
    }

    onBrightnessLevelChanged: {
        if (brightnessLevel > 1.0)
            brightnessLevel = 1.0;
        if (brightnessLevel < 0.0)
            brightnessLevel = 0.0;
        brightnessSetProc.running = true;
    }

    Component.onCompleted: {
        usernameProc.running = true;
        hostnameProc.running = true;
        uptimeProc.running = true;
        kernelProc.running = true;
        volumeGetProc.running = true;
        brightnessGetProc.running = true;
        wifiSsidProc.running = true;
    }

    Rectangle {
        anchors.fill: parent
        color: profilePanel.config.colors.bgCard
        radius: Math.round(16 * hyprlandScale)
        border.width: Math.max(1, Math.round(1 * hyprlandScale))
        border.color: profilePanel.config.colors.bgHighlight

        Flickable {
            anchors.fill: parent
            anchors.margins: Math.round(20 * hyprlandScale)
            contentHeight: mainColumn.height
            clip: true

            Column {
                id: mainColumn
                width: parent.width
                spacing: Math.round(20 * hyprlandScale)

                // Header Row
                Row {
                    width: parent.width
                    spacing: Math.round(12 * hyprlandScale)

                    Text {
                        text: "Quick Settings"
                        font.family: profilePanel.config.fontFamily
                        font.pixelSize: Math.round(18 * hyprlandScale)
                        font.weight: Font.Bold
                        color: profilePanel.config.colors.fg
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Item {
                        width: parent.width - Math.round(250 * hyprlandScale)
                        height: 1
                    }

                    Rectangle {
                        width: Math.round(40 * hyprlandScale)
                        height: Math.round(40 * hyprlandScale)
                        radius: Math.round(20 * hyprlandScale)
                        color: profilePanel.config.colors.bg
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: "⚙"
                            anchors.centerIn: parent
                            font.pixelSize: Math.round(20 * hyprlandScale)
                            color: profilePanel.config.colors.fg
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (profilePanel.settingsWindow) {
                                    profilePanel.settingsWindow.visible = !profilePanel.settingsWindow.visible;
                                }
                            }
                        }
                    }
                }

                // User Info Card
                UserInfoCard {
                    config: profilePanel.config
                    username: usernameText.text
                    uptime: uptimeText.text
                    scale: profilePanel.hyprlandScale
                }

                // Quick Toggles Grid
                QuickTogglesGrid {
                    config: profilePanel.config
                    wifiEnabled: profilePanel.wifiEnabled
                    bluetoothEnabled: profilePanel.bluetoothEnabled
                    focusModeEnabled: profilePanel.focusModeEnabled
                    darkThemeEnabled: profilePanel.darkThemeEnabled
                    wifiSsid: profilePanel.wifiSsid
                    scale: profilePanel.hyprlandScale

                    onWifiToggled: {
                        profilePanel.wifiEnabled = !profilePanel.wifiEnabled;
                        wifiProc.running = true;
                    }
                    onBluetoothToggled: {
                        profilePanel.bluetoothEnabled = !profilePanel.bluetoothEnabled;
                        btProc.running = true;
                    }
                    onFocusModeToggled: {
                        profilePanel.focusModeEnabled = !profilePanel.focusModeEnabled;
                    }
                    onDarkThemeToggled: {
                        profilePanel.darkThemeEnabled = !profilePanel.darkThemeEnabled;
                    }
                }

                // Volume Slider
                SliderControl {
                    config: profilePanel.config
                    icon: "󰕾"
                    label: "Volume"
                    value: profilePanel.volumeLevel
                    scale: profilePanel.hyprlandScale
                    onValueChanged: {
                        profilePanel.volumeLevel = value;
                    }
                }

                // Brightness Slider
                SliderControl {
                    config: profilePanel.config
                    icon: "󰃠"
                    label: "Brightness"
                    value: profilePanel.brightnessLevel
                    scale: profilePanel.hyprlandScale
                    onValueChanged: {
                        profilePanel.brightnessLevel = value;
                    }
                }

                // Separator
                Rectangle {
                    width: parent.width
                    height: Math.max(1, Math.round(2 * hyprlandScale))
                    color: profilePanel.config.colors.bgHighlight
                    opacity: 0.2
                }

                // System Monitor
                SystemMonitorSection {
                    config: profilePanel.config
                    cpuText: cpuPercent.text
                    ramText: ramPercent.text
                    gpuText: gpuPercent.text
                    tempText: tempText.text
                    cpuCanvas: cpuCanvas
                    ramCanvas: ramCanvas
                    gpuCanvas: gpuCanvas
                    tempCanvas: tempCanvas
                    scale: profilePanel.hyprlandScale
                }

                // System Info Card
                SystemInfoCard {
                    config: profilePanel.config
                    hostname: hostnameText.text
                    kernel: kernelText.text
                    uptime: uptimeText.text
                    scale: profilePanel.hyprlandScale
                }

                // Power Options
                PowerOptionsRow {
                    config: profilePanel.config
                    scale: profilePanel.hyprlandScale
                }

                // Bottom padding
                Item {
                    width: parent.width
                    height: Math.round(10 * hyprlandScale)
                }
            }
        }
    }

    // Hidden Canvas elements for system monitoring
    Canvas {
        id: cpuCanvas
        visible: false
        property real percentage: 0
    }

    NumberAnimation {
        id: cpuAnim
        target: cpuCanvas
        property: "percentage"
        duration: 750
        easing.type: Easing.InOutQuad
    }

    Canvas {
        id: ramCanvas
        visible: false
        property real percentage: 0
    }

    NumberAnimation {
        id: ramAnim
        target: ramCanvas
        property: "percentage"
        duration: 750
        easing.type: Easing.InOutQuad
    }

    Canvas {
        id: gpuCanvas
        visible: false
        property real percentage: 0
    }

    NumberAnimation {
        id: gpuAnim
        target: gpuCanvas
        property: "percentage"
        duration: 750
        easing.type: Easing.InOutQuad
    }

    Canvas {
        id: tempCanvas
        visible: false
        property real percentage: 0
        property real temperature: 0
    }

    NumberAnimation {
        id: tempAnim
        target: tempCanvas
        property: "percentage"
        duration: 750
        easing.type: Easing.InOutQuad
    }

    // Hidden text elements for data storage
    Text {
        id: cpuPercent
        text: "0%"
        visible: false
    }

    Text {
        id: ramPercent
        text: "0%"
        visible: false
    }

    Text {
        id: gpuPercent
        text: "N/A"
        visible: false
    }

    Text {
        id: tempText
        text: "0°"
        visible: false
    }

    Text {
        id: usernameText
        text: "user"
        visible: false
    }

    Text {
        id: hostnameText
        text: "unknown"
        visible: false
    }

    Text {
        id: uptimeText
        text: "unknown"
        visible: false
    }

    Text {
        id: kernelText
        text: "unknown"
        visible: false
    }

    // Update timer
    Timer {
        id: updateTimer
        interval: 2000
        repeat: true
        running: profilePanel.loading
        triggeredOnStart: true
        onTriggered: {
            cpuProc.running = true;
            ramProc.running = true;
            gpuProc.running = true;
            tempProc.running = true;
            usernameProc.running = true;
            hostnameProc.running = true;
            uptimeProc.running = true;
            kernelProc.running = true;
            volumeGetProc.running = true;
            brightnessGetProc.running = true;
            wifiSsidProc.running = true;
        }
    }

    // System monitoring processes
    Process {
        id: cpuProc
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8}'"]
        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data);
                if (!isNaN(val)) {
                    cpuPercent.text = Math.round(val) + "%";
                    cpuAnim.to = val;
                    cpuAnim.start();
                }
            }
        }
    }

    Process {
        id: ramProc
        command: ["sh", "-c", "free | grep Mem | awk '{print ($3/$2) * 100.0}'"]
        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data);
                if (!isNaN(val)) {
                    ramPercent.text = Math.round(val) + "%";
                    ramAnim.to = val;
                    ramAnim.start();
                }
            }
        }
    }

    Process {
        id: gpuProc
        command: ["sh", "-c", "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo 'N/A'"]
        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data);
                if (!isNaN(val)) {
                    gpuPercent.text = Math.round(val) + "%";
                    gpuAnim.to = val;
                    gpuAnim.start();
                } else {
                    gpuPercent.text = "N/A";
                }
            }
        }
    }

    Process {
        id: tempProc
        command: ["sh", "-c", "sensors 2>/dev/null | grep -E 'Tctl:|Package id 0:|Tdie:|Core 0:' | head -1 | awk '{print $2}' | sed 's/+//;s/°C//' || cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | head -1 | awk '{print $1/1000}' || echo '0'"]
        stdout: SplitParser {
            onRead: data => {
                let val = parseFloat(data.trim());
                if (!isNaN(val) && val > 0) {
                    tempText.text = Math.round(val) + "°";
                    tempCanvas.temperature = val;
                    let percent = Math.min(100, (val / 100) * 100);
                    tempAnim.to = percent;
                    tempAnim.start();
                }
            }
        }
    }

    Process {
        id: usernameProc
        command: ["sh", "-c", "whoami 2>/dev/null || echo $USER || echo 'user'"]
        stdout: SplitParser {
            onRead: data => {
                var result = data.trim();
                if (result && result.length > 0) {
                    usernameText.text = result;
                }
            }
        }
    }

    Process {
        id: hostnameProc
        command: ["sh", "-c", "cat /etc/hostname 2>/dev/null || hostname 2>/dev/null || echo 'unknown'"]
        stdout: SplitParser {
            onRead: data => {
                var result = data.trim();
                if (result && result.length > 0) {
                    hostnameText.text = result;
                }
            }
        }
    }

    Process {
        id: uptimeProc
        command: ["sh", "-c", "uptime -p 2>/dev/null | sed 's/up //' || echo '0 min'"]
        stdout: SplitParser {
            onRead: data => {
                var result = data.trim();
                uptimeText.text = result;
            }
        }
    }

    Process {
        id: volumeGetProc
        command: ["sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\\d+(?=%)' | head -n1"]
        stdout: SplitParser {
            onRead: data => {
                let val = parseInt(data);
                if (!isNaN(val)) {
                    profilePanel.volumeLevel = val / 100.0;
                }
            }
        }
    }

    Process {
        id: volumeSetProc
        command: ["sh", "-c", "pactl set-sink-volume @DEFAULT_SINK@ " + Math.round(profilePanel.volumeLevel * 100) + "%"]
    }

    Process {
        id: brightnessGetProc
        command: ["sh", "-c", "echo $(brightnessctl g) $(brightnessctl m)"]
        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split(' ');
                if (parts.length === 2) {
                    let current = parseInt(parts[0]);
                    let max = parseInt(parts[1]);
                    if (!isNaN(current) && !isNaN(max) && max > 0) {
                        profilePanel.brightnessLevel = current / max;
                    }
                }
            }
        }
    }

    Process {
        id: brightnessSetProc
        command: ["sh", "-c", "brightnessctl set " + Math.round(profilePanel.brightnessLevel * 100) + "%"]
    }

    Process {
        id: kernelProc
        command: ["sh", "-c", "uname -r 2>/dev/null || echo 'Linux'"]
        stdout: SplitParser {
            onRead: data => {
                var result = data.trim();
                kernelText.text = result;
            }
        }
    }

    Process {
        id: wifiSsidProc
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
        stdout: SplitParser {
            onRead: data => {
                let ssid = data.trim();
                if (ssid && ssid.length > 0) {
                    profilePanel.wifiSsid = ssid;
                    profilePanel.wifiEnabled = true;
                } else {
                    profilePanel.wifiSsid = "WiFi";
                    profilePanel.wifiEnabled = false;
                }
            }
        }
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", profilePanel.wifiEnabled ? "nmcli radio wifi on" : "nmcli radio wifi off"]
        stdout: SplitParser {
            onRead: data => {
            // WiFi status check
            }
        }
    }

    Process {
        id: btProc
        command: ["sh", "-c", profilePanel.bluetoothEnabled ? "bluetoothctl power on" : "bluetoothctl power off"]
        stdout: SplitParser {
            onRead: data => {
            // Bluetooth status check
            }
        }
    }
}
