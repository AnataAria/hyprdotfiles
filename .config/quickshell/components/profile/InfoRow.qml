import QtQuick

Row {
    property var config
    property string icon: ""
    property string label: ""
    property string value: ""
    property real scale: 1.0
    
    spacing: Math.round(12 * scale)
    width: parent.width
    
    Text {
        text: icon
        font.family: config.fontFamily
        font.pixelSize: Math.round(16 * scale)
        color: config.colors.accent
        width: Math.round(24 * scale)
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Text {
        text: label
        font.family: config.fontFamily
        font.pixelSize: Math.round(13 * scale)
        color: config.colors.fgDim
        width: Math.round(100 * scale)
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Text {
        text: value
        font.family: config.fontFamilyMono
        font.pixelSize: Math.round(13 * scale)
        color: config.colors.fg
        width: parent.width - Math.round(150 * scale)
        elide: Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
    }
}
