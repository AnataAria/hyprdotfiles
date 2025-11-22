import QtQuick
import Quickshell
import Quickshell.Io

Row {
    id: sysMonitor

    property var config

    spacing: config.metrics.spacingLarge

    // CPU
    Row {
        spacing: 6

        Text {
            text: "󰻠"
            font.family: sysMonitor.config.fontFamily
            font.pixelSize: 20
            color: sysMonitor.config.colors.info
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: cpuText
            text: "0%"
            font.family: sysMonitor.config.fontFamilyMono
            font.pixelSize: sysMonitor.config.metrics.fontSmall
            font.weight: Font.Bold
            color: sysMonitor.config.colors.fg
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // RAM
    Row {
        spacing: 6

        Text {
            text: "󰍛"
            font.family: sysMonitor.config.fontFamily
            font.pixelSize: 20
            color: sysMonitor.config.colors.warning
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: ramText
            text: "0%"
            font.family: sysMonitor.config.fontFamilyMono
            font.pixelSize: sysMonitor.config.metrics.fontSmall
            font.weight: Font.Bold
            color: sysMonitor.config.colors.fg
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Battery
    Row {
        spacing: 6
        visible: batteryExists

        Text {
            id: batteryIcon
            text: "󰂎"
            font.family: sysMonitor.config.fontFamily
            font.pixelSize: 20
            color: {
                if (charging)
                    return sysMonitor.config.colors.success;
                if (batteryPercentage < 20)
                    return sysMonitor.config.colors.error;
                if (batteryPercentage < 50)
                    return sysMonitor.config.colors.warning;
                return sysMonitor.config.colors.fg;
            }
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: batteryText
            text: "0%"
            font.family: sysMonitor.config.fontFamilyMono
            font.pixelSize: sysMonitor.config.metrics.fontSmall
            font.weight: Font.Bold
            color: sysMonitor.config.colors.fg
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    property bool batteryExists: false
    property int batteryPercentage: 0
    property bool charging: false

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuProc.running = true;
            ramProc.running = true;
            batteryProc.running = true;
            chargingProc.running = true;
        }
    }

    Process {
        id: cpuProc
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'"]

        stdout: SplitParser {
            onRead: data => {
                var value = parseFloat(data.trim());
                if (!isNaN(value)) {
                    cpuText.text = Math.round(value) + "%";
                }
            }
        }
    }

    Process {
        id: ramProc
        command: ["sh", "-c", "free | grep Mem | awk '{print ($3/$2) * 100.0}'"]

        stdout: SplitParser {
            onRead: data => {
                var value = parseFloat(data.trim());
                if (!isNaN(value)) {
                    ramText.text = Math.round(value) + "%";
                }
            }
        }
    }

    Process {
        id: batteryProc
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo '0'"]

        stdout: SplitParser {
            onRead: data => {
                var value = parseInt(data.trim());
                if (!isNaN(value) && value > 0) {
                    sysMonitor.batteryExists = true;
                    sysMonitor.batteryPercentage = value;
                    batteryText.text = value + "%";
                    updateBatteryIcon();
                }
            }
        }
    }

    Process {
        id: chargingProc
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/status 2>/dev/null || echo 'Unknown'"]

        stdout: SplitParser {
            onRead: data => {
                var status = data.trim();
                sysMonitor.charging = (status === "Charging" || status === "Full");
                updateBatteryIcon();
            }
        }
    }

    function updateBatteryIcon() {
        if (charging) {
            batteryIcon.text = "󰂄";
        } else if (batteryPercentage >= 90) {
            batteryIcon.text = "󰁹";
        } else if (batteryPercentage >= 80) {
            batteryIcon.text = "󰂂";
        } else if (batteryPercentage >= 70) {
            batteryIcon.text = "󰂁";
        } else if (batteryPercentage >= 60) {
            batteryIcon.text = "󰂀";
        } else if (batteryPercentage >= 50) {
            batteryIcon.text = "󰁿";
        } else if (batteryPercentage >= 40) {
            batteryIcon.text = "󰁾";
        } else if (batteryPercentage >= 30) {
            batteryIcon.text = "󰁽";
        } else if (batteryPercentage >= 20) {
            batteryIcon.text = "󰁼";
        } else if (batteryPercentage >= 10) {
            batteryIcon.text = "󰁻";
        } else {
            batteryIcon.text = "󰂎";
        }
    }
}
