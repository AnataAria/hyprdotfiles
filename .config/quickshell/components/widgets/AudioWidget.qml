import QtQuick
import Quickshell
import Quickshell.Io

Row {
    id: audioWidget

    property var config
    property int volume: 0
    property bool muted: false

    spacing: 6

    Text {
        id: volumeIcon
        font.family: audioWidget.config.fontFamily
        font.pixelSize: 20
        color: audioWidget.muted ? audioWidget.config.colors.fgDim : audioWidget.config.colors.accent
        anchors.verticalCenter: parent.verticalCenter
        text: "󰕾"
    }

    Text {
        id: volumeText
        font.family: audioWidget.config.fontFamilyMono
        font.pixelSize: audioWidget.config.metrics.fontSmall
        font.weight: Font.Bold
        color: audioWidget.config.colors.fg
        anchors.verticalCenter: parent.verticalCenter
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            volumeProc.running = true;
            muteProc.running = true;
        }
    }

    Process {
        id: volumeProc
        command: ["sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\\d+%' | head -n1 | tr -d '%'"]

        stdout: SplitParser {
            onRead: data => {
                var value = parseInt(data.trim());
                if (!isNaN(value)) {
                    audioWidget.volume = value;
                    audioWidget.updateDisplay();
                }
            }
        }
    }

    Process {
        id: muteProc
        command: ["sh", "-c", "pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes' && echo '1' || echo '0'"]

        stdout: SplitParser {
            onRead: data => {
                audioWidget.muted = data.trim() === "1";
                audioWidget.updateDisplay();
            }
        }
    }

    function updateDisplay() {
        volumeText.text = volume + "%";

        if (muted) {
            volumeIcon.text = "󰖁";
        } else if (volume >= 70) {
            volumeIcon.text = "󰕾";
        } else if (volume >= 30) {
            volumeIcon.text = "󰖀";
        } else if (volume > 0) {
            volumeIcon.text = "󰕿";
        } else {
            volumeIcon.text = "󰖁";
        }
    }
}
