import QtQuick
import Quickshell
import Quickshell.Io

Row {
    id: batteryWidget

    property var config
    property bool batteryExists: false
    property int percentage: 0
    property bool charging: false

    spacing: 6
    visible: batteryExists

    Component.onCompleted: {
        batteryProc.running = true;
        chargingProc.running = true;
    }

    Text {
        id: batteryIcon
        font.family: batteryWidget.config.fontFamily
        font.pixelSize: 20
        color: {
            if (batteryWidget.charging)
                return batteryWidget.config.colors.success;
            if (batteryWidget.percentage < 20)
                return batteryWidget.config.colors.error;
            if (batteryWidget.percentage < 50)
                return batteryWidget.config.colors.warning;
            return batteryWidget.config.colors.fg;
        }
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: batteryText
        font.family: batteryWidget.config.fontFamilyMono
        font.pixelSize: batteryWidget.config.metrics.fontSmall
        font.weight: Font.Bold
        color: batteryWidget.config.colors.fg
        anchors.verticalCenter: parent.verticalCenter
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            batteryProc.running = true;
            chargingProc.running = true;
        }
    }

    Process {
        id: batteryProc
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo '0'"]

        stdout: SplitParser {
            onRead: data => {
                var value = parseInt(data.trim());
                if (!isNaN(value) && value > 0) {
                    batteryWidget.batteryExists = true;
                    batteryWidget.percentage = value;
                    batteryWidget.updateDisplay();
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
                batteryWidget.charging = (status === "Charging" || status === "Full");
                batteryWidget.updateDisplay();
            }
        }
    }

    function updateDisplay() {
        batteryText.text = percentage + "%";

        if (charging) {
            batteryIcon.text = "";
        } else if (percentage >= 90) {
            batteryIcon.text = "";
        } else if (percentage >= 70) {
            batteryIcon.text = "";
        } else if (percentage >= 50) {
            batteryIcon.text = "";
        } else if (percentage >= 30) {
            batteryIcon.text = "";
        } else if (percentage >= 10) {
            batteryIcon.text = "";
        } else {
            batteryIcon.text = "";
        }
    }
}
