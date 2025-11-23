import QtQuick

Rectangle {
    id: sliderControl

    property var config
    property string icon: ""
    property string label: ""
    property real value: 0.5
    property real scale: 1.0

    width: parent.width
    height: Math.round(70 * scale)
    radius: Math.round(12 * scale)
    color: config.colors.bg

    Column {
        anchors {
            fill: parent
            margins: Math.round(16 * scale)
        }
        spacing: Math.round(8 * scale)

        Row {
            width: parent.width
            spacing: Math.round(8 * scale)

            Text {
                text: sliderControl.icon
                font.family: sliderControl.config.fontFamily
                font.pixelSize: Math.round(20 * scale)
                color: sliderControl.config.colors.fg
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: sliderControl.label
                font.family: sliderControl.config.fontFamily
                font.pixelSize: Math.round(14 * scale)
                font.weight: Font.Medium
                color: sliderControl.config.colors.fg
                anchors.verticalCenter: parent.verticalCenter
                width: Math.round(80 * scale)
            }

            Item {
                width: parent.width - Math.round(180 * scale)
                height: 1
            }

            Text {
                text: Math.min(100, Math.max(0, Math.round(sliderControl.value * 100))) + "%"
                font.family: sliderControl.config.fontFamilyMono
                font.pixelSize: Math.round(13 * scale)
                color: sliderControl.config.colors.fgDim
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignRight
                width: Math.round(45 * scale)
            }
        }

        Rectangle {
            id: track
            width: parent.width
            height: Math.round(6 * scale)
            radius: Math.round(3 * scale)
            color: sliderControl.config.colors.workspaceInactive

            Rectangle {
                width: parent.width * sliderControl.value
                height: parent.height
                radius: Math.round(3 * scale)
                color: sliderControl.config.colors.accent
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: false
                preventStealing: true
                onClicked: function (mouse) {
                    sliderControl.value = Math.max(0, Math.min(1, mouse.x / width));
                }
                onPositionChanged: function (mouse) {
                    if (pressed) {
                        sliderControl.value = Math.max(0, Math.min(1, mouse.x / width));
                    }
                }
            }
        }
    }
}
