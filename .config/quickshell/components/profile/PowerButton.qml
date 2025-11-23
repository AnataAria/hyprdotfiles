import QtQuick

Rectangle {
    property var config
    property string icon: ""
    property string label: ""
    property real scale: 1.0
    
    signal clicked
    
    height: Math.round(60 * scale)
    radius: Math.round(12 * scale)
    color: config.colors.bg
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: false
        cursorShape: Qt.PointingHandCursor
        onClicked: parent.clicked()
    }
    
    Column {
        anchors.centerIn: parent
        spacing: Math.round(8 * scale)
        
        Text {
            text: icon
            font.family: config.fontFamily
            font.pixelSize: Math.round(24 * scale)
            color: config.colors.fg
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Text {
            text: label
            font.family: config.fontFamily
            font.pixelSize: Math.round(11 * scale)
            color: config.colors.fgDim
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
