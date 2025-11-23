import QtQuick
import "."

Column {
    property var config
    property string cpuText: "0%"
    property string ramText: "0%"
    property string gpuText: "N/A"
    property string tempText: "0°"
    property var cpuCanvas
    property var ramCanvas
    property var gpuCanvas
    property var tempCanvas
    property real scale: 1.0
    
    width: parent.width
    spacing: Math.round(16 * scale)
    
    Text {
        text: "System Monitor"
        font.family: config.fontFamily
        font.pixelSize: Math.round(16 * scale)
        font.weight: Font.Bold
        color: config.colors.fg
    }
    
    Row {
        spacing: Math.round(15 * scale)
        anchors.horizontalCenter: parent.horizontalCenter
        
        MonitorCircle {
            config: parent.parent.config
            label: "CPU"
            valueText: parent.parent.cpuText
            circleColor: config.colors.info
            canvas: parent.parent.cpuCanvas
            scale: parent.parent.scale
        }
        
        MonitorCircle {
            config: parent.parent.config
            label: "RAM"
            valueText: parent.parent.ramText
            circleColor: config.colors.warning
            canvas: parent.parent.ramCanvas
            scale: parent.parent.scale
        }
        
        MonitorCircle {
            config: parent.parent.config
            label: "GPU"
            valueText: parent.parent.gpuText
            circleColor: config.colors.success
            canvas: parent.parent.gpuCanvas
            scale: parent.parent.scale
        }
        
        MonitorCircle {
            config: parent.parent.config
            label: "TEMP"
            valueText: parent.parent.tempText
            circleColor: parent.parent.tempCanvas && parent.parent.tempCanvas.temperature > 80 ? config.colors.error : parent.parent.tempCanvas && parent.parent.tempCanvas.temperature > 60 ? config.colors.warning : config.colors.purple
            canvas: parent.parent.tempCanvas
            scale: parent.parent.scale
        }
    }
}
