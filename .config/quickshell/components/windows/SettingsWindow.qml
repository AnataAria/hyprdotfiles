import QtQuick
import Quickshell
import Quickshell.Wayland

FloatingWindow {
    id: settingsWindow
    
    property var config
    property var screen
    
    visible: false
    width: 900
    height: 650
    
    color: "transparent"
    
    Rectangle {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        color: config.colors.bgCard
        radius: 16
        
        Text {
            anchors.centerIn: parent
            text: "Settings Window (Coming Soon)"
            font.family: config.fontFamily
            font.pixelSize: 24
            color: config.colors.fg
        }
    }
}
