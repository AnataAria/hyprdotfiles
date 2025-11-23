import QtQuick
import "."

Column {
    property var config
    property bool wifiEnabled: true
    property bool bluetoothEnabled: false
    property bool focusModeEnabled: false
    property bool darkThemeEnabled: true
    property string wifiSsid: "WiFi"
    property real scale: 1.0
    
    signal wifiToggled
    signal bluetoothToggled
    signal focusModeToggled
    signal darkThemeToggled
    
    width: parent.width
    spacing: Math.round(12 * scale)
    
    Row {
        width: parent.width
        spacing: Math.round(12 * scale)
        
        QuickToggle {
            config: parent.parent.config
            width: (parent.width - Math.round(12 * parent.parent.scale)) / 2
            icon: parent.parent.wifiEnabled ? "󰖩" : "󰖪"
            label: "Network"
            subtitle: parent.parent.wifiEnabled ? parent.parent.wifiSsid : "Off"
            active: parent.parent.wifiEnabled
            scale: parent.parent.scale
            onClicked: parent.parent.wifiToggled()
        }
        
        QuickToggle {
            config: parent.parent.config
            width: (parent.width - Math.round(12 * parent.parent.scale)) / 2
            icon: parent.parent.bluetoothEnabled ? "󰂯" : "󰂲"
            label: "Bluetooth"
            subtitle: parent.parent.bluetoothEnabled ? "On" : "Off"
            active: parent.parent.bluetoothEnabled
            scale: parent.parent.scale
            onClicked: parent.parent.bluetoothToggled()
        }
    }
    
    Row {
        width: parent.width
        spacing: Math.round(12 * scale)
        
        QuickToggle {
            config: parent.parent.config
            width: (parent.width - Math.round(12 * parent.parent.scale)) / 2
            icon: parent.parent.focusModeEnabled ? "󰂛" : "󰂛"
            label: "Focus Mode"
            subtitle: parent.parent.focusModeEnabled ? "On" : "Off"
            active: parent.parent.focusModeEnabled
            scale: parent.parent.scale
            onClicked: parent.parent.focusModeToggled()
        }
        
        QuickToggle {
            config: parent.parent.config
            width: (parent.width - Math.round(12 * parent.parent.scale)) / 2
            icon: parent.parent.darkThemeEnabled ? "󰔎" : "󰖔"
            label: "Interface"
            subtitle: parent.parent.darkThemeEnabled ? "On" : "Off"
            active: parent.parent.darkThemeEnabled
            scale: parent.parent.scale
            onClicked: parent.parent.darkThemeToggled()
        }
    }
}
