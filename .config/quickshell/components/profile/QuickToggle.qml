import QtQuick

Rectangle {
    id: quickToggle
    
    property var config
    property string icon: ""
    property string label: ""
    property string subtitle: ""
    property bool active: false
    property real scale: 1.0
    
    signal clicked
    
    height: Math.round(100 * scale)
    radius: Math.round(12 * scale)
    color: active ? config.colors.accent : config.colors.bg
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: false
        cursorShape: Qt.PointingHandCursor
        onClicked: quickToggle.clicked()
    }
    
    Column {
        anchors {
            left: parent.left
            leftMargin: Math.round(12 * scale)
            right: parent.right
            rightMargin: Math.round(12 * scale)
            top: parent.top
            topMargin: Math.round(12 * scale)
            bottom: parent.bottom
            bottomMargin: Math.round(12 * scale)
        }
        spacing: Math.round(6 * scale)
        clip: false
        
        Text {
            text: quickToggle.icon
            font.family: quickToggle.config.fontFamily
            font.pixelSize: Math.round(24 * scale)
            color: quickToggle.active ? quickToggle.config.colors.accentFg : quickToggle.config.colors.fg
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Text {
            text: quickToggle.label
            font.family: quickToggle.config.fontFamily
            font.pixelSize: Math.round(14 * scale)
            font.weight: Font.Bold
            color: quickToggle.active ? quickToggle.config.colors.accentFg : quickToggle.config.colors.fg
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }
        
        Text {
            text: quickToggle.subtitle
            font.family: quickToggle.config.fontFamily
            font.pixelSize: Math.round(11 * scale)
            color: quickToggle.active ? quickToggle.config.colors.accentFg : quickToggle.config.colors.fgDim
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }
    }
}
