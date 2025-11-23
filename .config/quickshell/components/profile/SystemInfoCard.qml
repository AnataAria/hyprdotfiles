import QtQuick
import "."

Rectangle {
    property var config
    property string hostname: "unknown"
    property string kernel: "unknown"
    property string uptime: "unknown"
    property real scale: 1.0
    
    width: parent.width
    height: systemInfoCol.height + Math.round(24 * scale)
    radius: Math.round(12 * scale)
    color: config.colors.bg
    
    Column {
        id: systemInfoCol
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: Math.round(16 * scale)
        }
        spacing: Math.round(12 * scale)
        
        Text {
            text: "System Information"
            font.family: config.fontFamily
            font.pixelSize: Math.round(14 * scale)
            font.weight: Font.Bold
            color: config.colors.fg
        }
        
        InfoRow {
            config: parent.parent.config
            icon: "󰌢"
            label: "Hostname"
            value: parent.parent.hostname
            scale: parent.parent.scale
        }
        
        InfoRow {
            config: parent.parent.config
            icon: "󰌽"
            label: "Kernel"
            value: parent.parent.kernel
            scale: parent.parent.scale
        }
        
        InfoRow {
            config: parent.parent.config
            icon: "󰥔"
            label: "Uptime"
            value: parent.parent.uptime
            scale: parent.parent.scale
        }
    }
}
