import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30
    exclusiveZone: implicitHeight
    color: "#161c27"

    property string monitorName: ""
    property string currentWorkspace: "󰍹 workspace"
    property string activeWindow: "desktop"
    property string networkTrafficInfo: ""
    property string bluetoothInfo: "󰂲"
    property string cpuInfo: "󰻠 --%"
    property string memoryInfo: "󰍛 --"
    property string diskInfo: "󰋊 --"
    property string audioInfo: "󰖁 muted"
    property string microphoneInfo: "󰍭"
    property bool hasBattery: false
    property string batteryInfo: ""
    property string dateInfo: ""
    property string timeInfo: ""

    component StatusBlock: Rectangle {
        required property string label
        required property color blockColor

        implicitWidth: statusLabel.implicitWidth + 18
        implicitHeight: 30
        color: blockColor

        Text {
            id: statusLabel
            anchors.centerIn: parent
            text: parent.label
            color: "#e6e9ef"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 12
            font.weight: Font.DemiBold
        }
    }

    function updateMonitorName() {
        var monitor = Hyprland.monitorFor(screen);
        if (monitor)
            monitorName = monitor.name;
    }

    function updateClock() {
        var now = new Date();
        dateInfo = "󰃭 " + Qt.formatDateTime(now, "ddd, MMM dd yyyy");
        timeInfo = "󰥔 " + Qt.formatDateTime(now, "HH:mm");
    }

    Component.onCompleted: {
        updateMonitorName();
        updateClock();
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: workspaceRow
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            implicitWidth: workspaceLabel.implicitWidth + 18
            color: "#7a62aa"

            Text {
                id: workspaceLabel
                anchors.centerIn: parent
                text: bar.currentWorkspace
                color: "#ffffff"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 12
                font.weight: Font.Bold
            }
        }

        Text {
            id: activeWindowLabel
            anchors {
                left: workspaceRow.right
                leftMargin: 14
                right: statusRow.left
                rightMargin: 14
                verticalCenter: parent.verticalCenter
            }
            text: bar.activeWindow
            color: "#aeb8c9"
            elide: Text.ElideRight
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 12
            font.weight: Font.Medium
        }

        Row {
            id: statusRow
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            spacing: 1

            StatusBlock {
                visible: bar.networkTrafficInfo.length > 0
                label: bar.networkTrafficInfo
                blockColor: "#3e5265"
            }

            StatusBlock {
                label: bar.bluetoothInfo
                blockColor: "#4f4568"
            }

            StatusBlock {
                label: bar.cpuInfo
                blockColor: "#485569"
            }

            StatusBlock {
                label: bar.memoryInfo
                blockColor: "#39495e"
            }

            StatusBlock {
                label: bar.diskInfo
                blockColor: "#303d51"
            }

            StatusBlock {
                label: bar.audioInfo
                blockColor: "#934657"
            }

            StatusBlock {
                label: bar.microphoneInfo
                blockColor: "#435069"
            }

            StatusBlock {
                visible: bar.hasBattery
                label: bar.batteryInfo
                blockColor: "#374255"
            }

            StatusBlock {
                label: bar.dateInfo
                blockColor: "#273346"
            }

            StatusBlock {
                label: bar.timeInfo
                blockColor: "#202938"
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            bar.updateClock();
            activeWindowProcess.running = true;
            audioProcess.running = true;
            microphoneProcess.running = true;
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            bar.updateMonitorName();
            workspaceProcess.running = true;
            bluetoothProcess.running = true;
            memoryProcess.running = true;
            diskProcess.running = true;
            batteryProcess.running = true;
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            networkTrafficProcess.running = true;
            cpuProcess.running = true;
        }
    }

    Process {
        id: workspaceProcess
        command: ["hyprctl", "workspaces", "-j"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var list = JSON.parse(this.text);
                    for (var index = 0; index < list.length; index++) {
                        var workspace = list[index];
                        if (workspace.monitor === bar.monitorName && workspace.id > 0) {
                            bar.currentWorkspace = "󰍹 " + workspace.name;
                            break;
                        }
                    }
                } catch (error) {
                    console.warn("Could not read Hyprland workspaces:", error);
                }
            }
        }
    }

    Process {
        id: activeWindowProcess
        command: ["hyprctl", "activewindow", "-j"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var window = JSON.parse(this.text);
                    var title = window.title || window.initialTitle || "desktop";
                    var appClass = window.class || window.initialClass || "";
                    bar.activeWindow = appClass.length > 0 ? appClass + "  " + title : title;
                } catch (error) {
                    bar.activeWindow = "desktop";
                }
            }
        }
    }

    Process {
        id: networkTrafficProcess
        command: ["sh", "-c", "iface=$(ip route get 1.1.1.1 2>/dev/null | awk '/dev/ {for (i = 1; i <= NF; i++) if ($i == \"dev\") { print $(i + 1); exit }}'); [ -n \"$iface\" ] || exit; address=$(ip -o -4 addr show dev \"$iface\" scope global | awk '{split($4, value, \"/\"); print value[1]; exit}'); first=$(awk -F'[: ]+' -v iface=\"$iface\" '$1 == iface {print $2, $10}' /proc/net/dev); sleep 1; second=$(awk -F'[: ]+' -v iface=\"$iface\" '$1 == iface {print $2, $10}' /proc/net/dev); set -- $first $second; [ $# -eq 4 ] || exit; printf '󰈀 %s  ↓%dKiB/s ↑%dKiB/s' \"$address\" \"$((($3 - $1) / 1024))\" \"$((($4 - $2) / 1024))\""]

        stdout: StdioCollector {
            onStreamFinished: bar.networkTrafficInfo = this.text.trim()
        }
    }

    Process {
        id: bluetoothProcess
        command: ["sh", "-c", "state=$(bluetoothctl show 2>/dev/null | awk -F': ' '/Powered:/ {print $2}'); if [ \"$state\" = yes ]; then printf '󰂯'; else printf '󰂲'; fi"]

        stdout: StdioCollector {
            onStreamFinished: bar.bluetoothInfo = this.text.trim()
        }
    }

    Process {
        id: cpuProcess
        command: ["sh", "-c", "first=$(awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5; exit}' /proc/stat); sleep 1; second=$(awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5; exit}' /proc/stat); set -- $first $second; total=$(($3 - $1)); idle=$(($4 - $2)); [ \"$total\" -gt 0 ] && printf '󰻠 %d%%' \"$(((total - idle) * 100 / total))\""]

        stdout: StdioCollector {
            onStreamFinished: {
                var value = this.text.trim();
                if (value.length > 0)
                    bar.cpuInfo = value;
            }
        }
    }

    Process {
        id: memoryProcess
        command: ["sh", "-c", "free -b | awk '/Mem:/ {printf \"󰍛 %.0f%%\", $3 * 100 / $2}'"]

        stdout: StdioCollector {
            onStreamFinished: bar.memoryInfo = this.text.trim()
        }
    }

    Process {
        id: diskProcess
        command: ["sh", "-c", "df -B1 / | awk 'NR == 2 {printf \"󰋊 %.0f%%\", $3 * 100 / $2}'"]

        stdout: StdioCollector {
            onStreamFinished: bar.diskInfo = this.text.trim()
        }
    }

    Process {
        id: audioProcess
        command: ["sh", "-c", "mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}'); volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -o '[0-9][0-9]*%' | head -n1 | tr -d '%'); if [ \"$mute\" = yes ]; then printf '󰖁'; elif [ -n \"$volume\" ]; then printf '󰕾 %s%%' \"$volume\"; else printf '󰖁'; fi"]

        stdout: StdioCollector {
            onStreamFinished: bar.audioInfo = this.text.trim()
        }
    }

    Process {
        id: microphoneProcess
        command: ["sh", "-c", "mute=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | awk '{print $2}'); if [ \"$mute\" = no ]; then printf '󰍬'; else printf '󰍭'; fi"]

        stdout: StdioCollector {
            onStreamFinished: bar.microphoneInfo = this.text.trim()
        }
    }

    Process {
        id: batteryProcess
        command: ["sh", "-c", "for battery in /sys/class/power_supply/BAT*; do [ -r \"$battery/capacity\" ] || continue; capacity=$(cat \"$battery/capacity\"); state=$(cat \"$battery/status\" 2>/dev/null); if [ \"$state\" = Charging ] || [ \"$state\" = Full ]; then icon='󰂄'; else icon='󰁹'; fi; printf '%s %s%%' \"$icon\" \"$capacity\"; break; done"]

        stdout: StdioCollector {
            onStreamFinished: {
                bar.batteryInfo = this.text.trim();
                bar.hasBattery = bar.batteryInfo.length > 0;
            }
        }
    }
}
