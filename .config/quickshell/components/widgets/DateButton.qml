import QtQuick
import Quickshell

Rectangle {
    id: dateButton

    property var config
    property var settingsPanel
    property var barScreen

    implicitWidth: dateLabel.width + 32
    implicitHeight: parent.height
    color: "#fda4af"
    radius: dateButton.config.metrics.radiusSmall

    Text {
        id: dateLabel
        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), "MMM dd")
        font.family: dateButton.config.fontFamily
        font.pixelSize: dateButton.config.metrics.fontMedium
        font.weight: Font.Medium
        color: "#18181b"
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: dateLabel.text = Qt.formatDateTime(new Date(), "MMM dd")
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (dateButton.settingsPanel) {
                dateButton.settingsPanel.screen = dateButton.barScreen;
                dateButton.settingsPanel.loading = !dateButton.settingsPanel.loading;
            }
        }

        hoverEnabled: true
        onEntered: parent.color = "#fb7185"
        onExited: parent.color = "#fda4af"
    }

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }
}
