import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

PanelWindow {
    id: profilePanel

    property var config
    property bool loading: false
    property var screen
    property var settingsWindow

    anchors {
        right: true
        top: true
    }

    margins {
        right: 10
        top: 10
    }

    implicitWidth: 420
    implicitHeight: 700
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

    Rectangle {
        anchors.fill: parent
        color: profilePanel.config.colors.bgCard
        radius: 16
        border.width: 1
        border.color: profilePanel.config.colors.bgHighlight

        Flickable {
            anchors.fill: parent
            anchors.margins: 20
            contentHeight: mainColumn.height
            clip: true

            Column {
                id: mainColumn
                width: parent.width
                spacing: 20

                Row {
                    width: parent.width
                    spacing: 12

                    Text {
                        text: "Quick Settings"
                        font.family: profilePanel.config.fontFamily
                        font.pixelSize: 18
                        font.weight: Font.Bold
                        color: profilePanel.config.colors.fg
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Item {
                        width: parent.width - 250
                        height: 1
                    }

                    Rectangle {
                        width: 40
                        height: 40
                        radius: 20
                        color: profilePanel.config.colors.bg
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            anchors.centerIn: parent
                            text: "󰒓"
                            font.family: profilePanel.config.fontFamily
                            font.pixelSize: 20
                            color: profilePanel.config.colors.fg
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (profilePanel.settingsWindow) {
                                    profilePanel.settingsWindow.visible = !profilePanel.settingsWindow.visible;
                                }
                            }
                            onEntered: parent.color = profilePanel.config.colors.bgCardHover
                            onExited: parent.color = profilePanel.config.colors.bg
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 100
                    radius: 12
                    color: profilePanel.config.colors.bg

                    Row {
                        anchors {
                            fill: parent
                            margins: 16
                        }
                        spacing: 16

                        Rectangle {
                            width: 68
                            height: 68
                            radius: 34
                            color: profilePanel.config.colors.accent
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                anchors.centerIn: parent
                                text: hostnameText.text.substring(0, 1).toUpperCase()
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 32
                                font.weight: Font.Bold
                                color: profilePanel.config.colors.accentFg
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 4
                            width: parent.width - 150

                            Text {
                                text: hostnameText.text
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 20
                                font.weight: Font.Bold
                                color: profilePanel.config.colors.fg
                            }

                            Text {
                                text: "󰥔 up " + uptimeText.text
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 13
                                color: profilePanel.config.colors.fgDim
                            }
                        }
                    }
                }

                Column {
                    width: parent.width
                    spacing: 12

                    Row {
                        width: parent.width
                        spacing: 12

                        QuickToggle {
                            config: profilePanel.config
                            width: (parent.width - 12) / 2
                            icon: profilePanel.wifiEnabled ? "󰖩" : "󰖪"
                            label: "Network"
                            subtitle: profilePanel.wifiEnabled ? profilePanel.wifiSsid : "Off"
                            active: profilePanel.wifiEnabled
                            onClicked: {
                                profilePanel.wifiEnabled = !profilePanel.wifiEnabled;
                                wifiProc.running = true;
                            }
                        }

                        QuickToggle {
                            config: profilePanel.config
                            width: (parent.width - 12) / 2
                            icon: profilePanel.bluetoothEnabled ? "󰂯" : "󰂲"
                            label: "Bluetooth"
                            subtitle: profilePanel.bluetoothEnabled ? "On" : "Off"
                            active: profilePanel.bluetoothEnabled
                            onClicked: {
                                profilePanel.bluetoothEnabled = !profilePanel.bluetoothEnabled;
                                btProc.running = true;
                            }
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 12

                        QuickToggle {
                            config: profilePanel.config
                            width: (parent.width - 12) / 2
                            icon: profilePanel.focusModeEnabled ? "󰂛" : "󰂛"
                            label: "Focus Mode"
                            subtitle: profilePanel.focusModeEnabled ? "On" : "Off"
                            active: profilePanel.focusModeEnabled
                            onClicked: {
                                profilePanel.focusModeEnabled = !profilePanel.focusModeEnabled;
                            }
                        }

                        QuickToggle {
                            config: profilePanel.config
                            width: (parent.width - 12) / 2
                            icon: profilePanel.darkThemeEnabled ? "󰔎" : "󰖔"
                            label: "Interface"
                            subtitle: profilePanel.darkThemeEnabled ? "On" : "Off"
                            active: profilePanel.darkThemeEnabled
                            onClicked: {
                                profilePanel.darkThemeEnabled = !profilePanel.darkThemeEnabled;
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 70
                    radius: 12
                    color: profilePanel.config.colors.bg

                    Column {
                        anchors {
                            fill: parent
                            margins: 16
                        }
                        spacing: 8

                        Row {
                            width: parent.width
                            spacing: 8

                            Text {
                                text: "󰕾"
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 20
                                color: profilePanel.config.colors.fg
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: "Volume"
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: profilePanel.config.colors.fg
                                anchors.verticalCenter: parent.verticalCenter
                                width: 80
                            }

                            Item {
                                width: parent.width - 180
                                height: 1
                            }

                            Text {
                                text: Math.min(100, Math.max(0, Math.round(profilePanel.volumeLevel * 100))) + "%"
                                font.family: profilePanel.config.fontFamilyMono
                                font.pixelSize: 13
                                color: profilePanel.config.colors.fgDim
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignRight
                                width: 45
                            }
                        }

                        Rectangle {
                            id: volumeTrack
                            width: parent.width
                            height: 6
                            radius: 3
                            color: profilePanel.config.colors.workspaceInactive

                            Rectangle {
                                width: parent.width * profilePanel.volumeLevel
                                height: parent.height
                                radius: 3
                                color: profilePanel.config.colors.accent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: function (mouse) {
                                    profilePanel.volumeLevel = Math.max(0, Math.min(1, mouse.x / width));
                                }
                                onPositionChanged: function (mouse) {
                                    if (pressed) {
                                        profilePanel.volumeLevel = Math.max(0, Math.min(1, mouse.x / width));
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 70
                    radius: 12
                    color: profilePanel.config.colors.bg

                    Column {
                        anchors {
                            fill: parent
                            margins: 16
                        }
                        spacing: 8

                        Row {
                            width: parent.width
                            spacing: 8

                            Text {
                                text: "󰃠"
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 20
                                color: profilePanel.config.colors.fg
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: "Brightness"
                                font.family: profilePanel.config.fontFamily
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: profilePanel.config.colors.fg
                                anchors.verticalCenter: parent.verticalCenter
                                width: 80
                            }

                            Item {
                                width: parent.width - 180
                                height: 1
                            }

                            Text {
                                text: Math.min(100, Math.max(0, Math.round(profilePanel.brightnessLevel * 100))) + "%"
                                font.family: profilePanel.config.fontFamilyMono
                                font.pixelSize: 13
                                color: profilePanel.config.colors.fgDim
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignRight
                                width: 45
                            }
                        }

                        Rectangle {
                            id: brightnessTrack
                            width: parent.width
                            height: 6
                            radius: 3
                            color: profilePanel.config.colors.workspaceInactive

                            Rectangle {
                                width: parent.width * profilePanel.brightnessLevel
                                height: parent.height
                                radius: 3
                                color: profilePanel.config.colors.accent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: function (mouse) {
                                    profilePanel.brightnessLevel = Math.max(0, Math.min(1, mouse.x / width));
                                }
                                onPositionChanged: function (mouse) {
                                    if (pressed) {
                                        profilePanel.brightnessLevel = Math.max(0, Math.min(1, mouse.x / width));
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: profilePanel.config.colors.fgDim
                    opacity: 0.2
                }

                Column {
                    width: parent.width
                    spacing: 16

                    Text {
                        text: "System Monitor"
                        font.family: profilePanel.config.fontFamily
                        font.pixelSize: 16
                        font.weight: Font.Bold
                        color: profilePanel.config.colors.fg
                    }

                    Row {
                        spacing: 15
                        anchors.horizontalCenter: parent.horizontalCenter

                        // CPU
                        MonitorCircle {
                            config: profilePanel.config
                            label: "CPU"
                            valueText: cpuPercent.text
                            circleColor: profilePanel.config.colors.info
                            canvas: cpuCanvas
                        }

                        // RAM
                        MonitorCircle {
                            config: profilePanel.config
                            label: "RAM"
                            valueText: ramPercent.text
                            circleColor: profilePanel.config.colors.warning
                            canvas: ramCanvas
                        }

                        // GPU
                        MonitorCircle {
                            config: profilePanel.config
                            label: "GPU"
                            valueText: gpuPercent.text
                            circleColor: profilePanel.config.colors.success
                            canvas: gpuCanvas
                        }

                        // TEMP
                        MonitorCircle {
                            config: profilePanel.config
                            label: "TEMP"
                            valueText: tempText.text
                            circleColor: tempCanvas.temperature > 80 ? profilePanel.config.colors.error : tempCanvas.temperature > 60 ? profilePanel.config.colors.warning : profilePanel.config.colors.purple
                            canvas: tempCanvas
                        }
                    }
                }

                // System Info
                Rectangle {
                    width: parent.width
                    height: systemInfoCol.height + 24
                    radius: 12
                    color: profilePanel.config.colors.bg

                    Column {
                        id: systemInfoCol
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            margins: 16
                        }
                        spacing: 12

                        Text {
                            text: "System Information"
                            font.family: profilePanel.config.fontFamily
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            color: profilePanel.config.colors.fg
                        }

                        InfoRow {
                            config: profilePanel.config
                            icon: "󰌢"
                            label: "Hostname"
                            value: hostnameText.text
                        }

                        InfoRow {
                            config: profilePanel.config
                            icon: "󰌽"
                            label: "Kernel"
                            value: kernelText.text
                        }

                        InfoRow {
                            config: profilePanel.config
                            icon: "󰥔"
                            label: "Uptime"
                            value: uptimeText.text
                        }
                    }
                }

                // Power Options
                Row {
                    width: parent.width
                    spacing: 12

                    PowerButton {
                        config: profilePanel.config
                        width: (parent.width - 24) / 3
                        icon: "󰌾"
                        label: "Lock"
                    }

                    PowerButton {
                        config: profilePanel.config
                        width: (parent.width - 24) / 3
                        icon: "󰜉"
                        label: "Restart"
                    }

                    PowerButton {
                        config: profilePanel.config
                        width: (parent.width - 24) / 3
                        icon: "󰐥"
                        label: "Shutdown"
                    }
                }

                // Bottom padding
                Item {
                    width: parent.width
                    height: 10
                }
            }
        }
    }

    // Hidden elements for canvas and data storage
    Canvas {
        id: cpuCanvas
        width: 70
        height: 70
        visible: false
        property real percentage: 0

        onPercentageChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 6;
            ctx.strokeStyle = profilePanel.config.colors.info;
            ctx.lineCap = "round";
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = 32;
            var startAngle = -Math.PI / 2;
            var endAngle = startAngle + (percentage / 100) * 2 * Math.PI;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
            ctx.stroke();
        }

        Behavior on percentage {
            NumberAnimation {
                duration: 300
            }
        }
    }

    Canvas {
        id: ramCanvas
        width: 70
        height: 70
        visible: false
        property real percentage: 0

        onPercentageChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 6;
            ctx.strokeStyle = profilePanel.config.colors.warning;
            ctx.lineCap = "round";
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = 32;
            var startAngle = -Math.PI / 2;
            var endAngle = startAngle + (percentage / 100) * 2 * Math.PI;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
            ctx.stroke();
        }

        Behavior on percentage {
            NumberAnimation {
                duration: 300
            }
        }
    }

    Canvas {
        id: gpuCanvas
        width: 70
        height: 70
        visible: false
        property real percentage: 0

        onPercentageChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 6;
            ctx.strokeStyle = profilePanel.config.colors.success;
            ctx.lineCap = "round";
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = 32;
            var startAngle = -Math.PI / 2;
            var endAngle = startAngle + (percentage / 100) * 2 * Math.PI;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
            ctx.stroke();
        }

        Behavior on percentage {
            NumberAnimation {
                duration: 300
            }
        }
    }

    Canvas {
        id: tempCanvas
        width: 70
        height: 70
        visible: false
        property real temperature: 0
        property real percentage: 0

        onTemperatureChanged: {
            percentage = Math.min(temperature, 100);
            requestPaint();
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 6;
            if (temperature > 80) {
                ctx.strokeStyle = profilePanel.config.colors.error;
            } else if (temperature > 60) {
                ctx.strokeStyle = profilePanel.config.colors.warning;
            } else {
                ctx.strokeStyle = profilePanel.config.colors.purple;
            }
            ctx.lineCap = "round";
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = 32;
            var startAngle = -Math.PI / 2;
            var endAngle = startAngle + (percentage / 100) * 2 * Math.PI;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
            ctx.stroke();
        }

        Behavior on percentage {
            NumberAnimation {
                duration: 300
            }
        }
    }

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

    // System monitoring timer
    Timer {
        interval: 2000
        running: profilePanel.loading
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuMonitorProc.running = true;
            ramMonitorProc.running = true;
            gpuMonitorProc.running = true;
            tempMonitorProc.running = true;
            hostnameProc.running = true;
            uptimeProc.running = true;
            kernelProc.running = true;
            wifiSsidProc.running = true;
            volumeGetProc.running = true;
            brightnessGetProc.running = true;
        }
    }

    // Processes
    Process {
        id: cpuMonitorProc
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'"]
        stdout: SplitParser {
            onRead: data => {
                var value = parseFloat(data.trim());
                if (!isNaN(value)) {
                    cpuPercent.text = Math.round(value) + "%";
                    cpuCanvas.percentage = value;
                }
            }
        }
    }

    Process {
        id: ramMonitorProc
        command: ["sh", "-c", "free | grep Mem | awk '{print ($3/$2) * 100.0}'"]
        stdout: SplitParser {
            onRead: data => {
                var value = parseFloat(data.trim());
                if (!isNaN(value)) {
                    ramPercent.text = Math.round(value) + "%";
                    ramCanvas.percentage = value;
                }
            }
        }
    }

    Process {
        id: gpuMonitorProc
        command: ["sh", "-c", "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || radeontop -d - -l 1 2>/dev/null | grep -oP 'gpu \\K[0-9]+' || cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo 'N/A'"]
        stdout: SplitParser {
            onRead: data => {
                var value = data.trim();
                if (value === "N/A" || value === "") {
                    gpuPercent.text = "N/A";
                    gpuCanvas.percentage = 0;
                } else {
                    var gpuValue = parseFloat(value);
                    if (!isNaN(gpuValue)) {
                        gpuPercent.text = Math.round(gpuValue) + "%";
                        gpuCanvas.percentage = gpuValue;
                    }
                }
            }
        }
    }

    Process {
        id: tempMonitorProc
        command: ["sh", "-c", "sensors | grep 'Tctl' | awk '{print $2}' | tr -d '+°C' || sensors | grep 'Package id 0' | awk '{print $4}' | tr -d '+°C' || cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null | awk '{print $1/1000}' || echo '0'"]
        stdout: SplitParser {
            onRead: data => {
                var value = parseFloat(data.trim());
                if (!isNaN(value)) {
                    tempText.text = Math.round(value) + "°";
                    tempCanvas.temperature = value;
                }
            }
        }
    }

    Process {
        id: hostnameProc
        command: ["sh", "-c", "cat /etc/hostname 2>/dev/null || cat /proc/sys/kernel/hostname 2>/dev/null || echo 'unknown'"]
        stdout: SplitParser {
            onRead: data => {
                hostnameText.text = data.trim();
            }
        }
    }

    Process {
        id: uptimeProc
        command: ["sh", "-c", "uptime -p | sed 's/up //'"]
        stdout: SplitParser {
            onRead: data => {
                uptimeText.text = data.trim();
            }
        }
    }

    Process {
        id: kernelProc
        command: ["uname", "-r"]
        stdout: SplitParser {
            onRead: data => {
                kernelText.text = data.trim();
            }
        }
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", wifiEnabled ? "nmcli radio wifi on" : "nmcli radio wifi off"]
        stdout: SplitParser {
            onRead: data => {
                console.log("WiFi:", data);
            }
        }
    }

    Process {
        id: wifiSsidProc
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
        stdout: SplitParser {
            onRead: data => {
                var ssid = data.trim();
                if (ssid !== "") {
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
        id: volumeGetProc
        command: ["sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+%' | head -1 | tr -d '%'"]
        stdout: SplitParser {
            onRead: data => {
                var vol = parseInt(data.trim());
                if (!isNaN(vol)) {
                    profilePanel.volumeLevel = Math.min(1.0, Math.max(0.0, vol / 100.0));
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
        command: ["sh", "-c", "brightnessctl -m | cut -d, -f4 | tr -d '%'"]
        stdout: SplitParser {
            onRead: data => {
                var bright = parseInt(data.trim());
                if (!isNaN(bright)) {
                    profilePanel.brightnessLevel = Math.min(1.0, Math.max(0.0, bright / 100.0));
                }
            }
        }
    }

    Process {
        id: brightnessSetProc
        command: ["sh", "-c", "brightnessctl set " + Math.round(profilePanel.brightnessLevel * 100) + "%"]
    }

    Process {
        id: btProc
        command: ["sh", "-c", bluetoothEnabled ? "bluetoothctl power on" : "bluetoothctl power off"]
        stdout: SplitParser {
            onRead: data => {
                console.log("Bluetooth:", data);
            }
        }
    }

    // Component Definitions
    component QuickToggle: Rectangle {
        id: quickToggle
        property var config
        property string icon: ""
        property string label: ""
        property string subtitle: ""
        property bool active: false
        signal clicked

        height: 100
        radius: 12
        color: active ? config.colors.accent : config.colors.bg

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: quickToggle.clicked()
            onEntered: {
                if (!quickToggle.active)
                    parent.color = config.colors.bgCardHover;
            }
            onExited: {
                if (!quickToggle.active)
                    parent.color = config.colors.bg;
            }
        }

        Column {
            anchors {
                left: parent.left
                leftMargin: 12
                right: parent.right
                rightMargin: 12
                top: parent.top
                topMargin: 12
                bottom: parent.bottom
                bottomMargin: 12
            }
            spacing: 6
            clip: false

            Text {
                text: quickToggle.icon
                font.family: quickToggle.config.fontFamily
                font.pixelSize: 24
                color: quickToggle.active ? quickToggle.config.colors.accentFg : quickToggle.config.colors.fg
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: quickToggle.label
                font.family: quickToggle.config.fontFamily
                font.pixelSize: 14
                font.weight: Font.Bold
                color: quickToggle.active ? quickToggle.config.colors.accentFg : quickToggle.config.colors.fg
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.NoWrap
                elide: Text.ElideRight
            }

            Text {
                text: quickToggle.subtitle
                font.family: quickToggle.config.fontFamily
                font.pixelSize: 11
                color: quickToggle.active ? quickToggle.config.colors.accentFg : quickToggle.config.colors.fgDim
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.NoWrap
                elide: Text.ElideRight
            }
        }
    }

    component MonitorCircle: Column {
        id: monitorCircle
        property var config
        property string label: ""
        property string valueText: "0%"
        property color circleColor: config.colors.info
        property var canvas
        property real percentage: canvas ? canvas.percentage : 0

        spacing: 6
        width: 70

        Item {
            width: 70
            height: 70
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                anchors.centerIn: parent
                width: 70
                height: 70
                radius: 35
                color: "transparent"
                border.width: 6
                border.color: monitorCircle.config.colors.workspaceInactive
            }

            Canvas {
                id: displayCanvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.lineWidth = 6;
                    ctx.strokeStyle = monitorCircle.circleColor;
                    ctx.lineCap = "round";
                    var centerX = width / 2;
                    var centerY = height / 2;
                    var radius = 32;
                    var startAngle = -Math.PI / 2;
                    var endAngle = startAngle + (monitorCircle.percentage / 100) * 2 * Math.PI;
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
                    ctx.stroke();
                }

                Connections {
                    target: monitorCircle.canvas
                    function onPercentageChanged() {
                        displayCanvas.requestPaint();
                    }
                }
            }

            Column {
                anchors.centerIn: parent
                Text {
                    text: monitorCircle.valueText
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: monitorCircle.config.fontFamilyMono
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    color: monitorCircle.config.colors.fg
                }
            }
        }

        Text {
            text: monitorCircle.label
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: monitorCircle.config.fontFamily
            font.pixelSize: 11
            color: monitorCircle.config.colors.fgDim
        }
    }

    component InfoRow: Row {
        property var config
        property string icon: ""
        property string label: ""
        property string value: ""

        spacing: 10
        width: parent.width

        Text {
            text: icon
            font.family: config.fontFamily
            font.pixelSize: 16
            color: config.colors.accent
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: label + ":"
            font.family: config.fontFamily
            font.pixelSize: 13
            color: config.colors.fgDim
            anchors.verticalCenter: parent.verticalCenter
            width: 80
        }

        Text {
            text: value
            font.family: config.fontFamilyMono
            font.pixelSize: 13
            color: config.colors.fg
            anchors.verticalCenter: parent.verticalCenter
            elide: Text.ElideRight
            width: parent.width - 120
        }
    }

    component PowerButton: Rectangle {
        property var config
        property string icon: ""
        property string label: ""

        height: 60
        radius: 12
        color: config.colors.bg

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: parent.color = config.colors.bgCardHover
            onExited: parent.color = config.colors.bg
        }

        Column {
            anchors.centerIn: parent
            spacing: 6

            Text {
                text: icon
                font.family: config.fontFamily
                font.pixelSize: 24
                color: config.colors.fg
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: label
                font.family: config.fontFamily
                font.pixelSize: 12
                color: config.colors.fgDim
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
