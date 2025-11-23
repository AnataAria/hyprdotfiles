import QtQuick
import "."

Row {
    property var config
    property real scale: 1.0
    
    signal lockClicked
    signal restartClicked
    signal shutdownClicked
    
    width: parent.width
    spacing: Math.round(12 * scale)
    
    PowerButton {
        config: parent.config
        width: (parent.width - Math.round(24 * scale)) / 3
        icon: "󰌾"
        label: "Lock"
        scale: parent.scale
        onClicked: parent.lockClicked()
    }
    
    PowerButton {
        config: parent.config
        width: (parent.width - Math.round(24 * scale)) / 3
        icon: "󰜉"
        label: "Restart"
        scale: parent.scale
        onClicked: parent.restartClicked()
    }
    
    PowerButton {
        config: parent.config
        width: (parent.width - Math.round(24 * scale)) / 3
        icon: "󰐥"
        label: "Shutdown"
        scale: parent.scale
        onClicked: parent.shutdownClicked()
    }
}
