import QtQuick
import Quickshell

Row {
    id: clockWidget
    spacing: 0

    property var config
    property string timeFormat: "h:mm AP"

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var now = new Date();
            timeText.text = Qt.formatDateTime(now, clockWidget.timeFormat);
        }
    }

    Text {
        id: timeText
        font.family: clockWidget.config.fontFamilyMono
        font.pixelSize: clockWidget.config.metrics.fontMedium
        font.weight: Font.DemiBold
        color: clockWidget.config.colors.fg
        anchors.verticalCenter: parent.verticalCenter
    }
}
