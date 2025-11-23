import QtQuick

Rectangle {
    property var config
    property string username: "user"
    property string uptime: "unknown"
    property real scale: 1.0

    width: parent.width
    height: Math.round(70 * scale)
    radius: Math.round(12 * scale)
    color: config.colors.bg

    Row {
        anchors {
            fill: parent
            margins: Math.round(16 * scale)
        }
        spacing: Math.round(12 * scale)

        Rectangle {
            width: Math.round(42 * scale)
            height: Math.round(42 * scale)
            radius: Math.round(21 * scale)
            color: config.colors.bgHighlight
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text: "🚀"
                font.pixelSize: Math.round(22 * scale)
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: Math.round(4 * scale)

            Text {
                text: username && username.length > 0 ? username : "Loading..."
                font.family: config.fontFamily
                font.pixelSize: Math.round(16 * scale)
                font.weight: Font.DemiBold
                color: config.colors.fg
            }

            Text {
                text: uptime && uptime.length > 0 && uptime !== "unknown" ? "Up " + uptime : "Loading..."
                font.family: config.fontFamilyMono
                font.pixelSize: Math.round(13 * scale)
                color: config.colors.fgDim
            }
        }
    }
}
