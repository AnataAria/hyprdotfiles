import QtQuick

Column {
    id: monitorCircle
    
    property var config
    property string label: ""
    property string valueText: "0%"
    property color circleColor: config.colors.info
    property var canvas
    property real percentage: canvas ? canvas.percentage : 0
    property real scale: 1.0
    
    readonly property int circleSize: Math.round(70 * scale)
    readonly property int circleRadius: Math.round(35 * scale)
    readonly property int borderWidth: Math.max(4, Math.round(6 * scale))
    
    spacing: Math.round(6 * scale)
    width: circleSize
    
    Item {
        width: monitorCircle.circleSize
        height: monitorCircle.circleSize
        anchors.horizontalCenter: parent.horizontalCenter
        
        Rectangle {
            anchors.centerIn: parent
            width: monitorCircle.circleSize
            height: monitorCircle.circleSize
            radius: monitorCircle.circleRadius
            color: "transparent"
            border.width: monitorCircle.borderWidth
            border.color: monitorCircle.config.colors.workspaceInactive
        }
        
        Canvas {
            id: displayCanvas
            anchors.fill: parent
            
            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);
                ctx.lineWidth = monitorCircle.borderWidth;
                ctx.strokeStyle = monitorCircle.circleColor;
                ctx.lineCap = "round";
                var centerX = width / 2;
                var centerY = height / 2;
                var radius = monitorCircle.circleRadius - monitorCircle.borderWidth / 2;
                var startAngle = -Math.PI / 2;
                var endAngle = startAngle + (monitorCircle.percentage / 100) * 2 * Math.PI;
                ctx.beginPath();
                ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
                ctx.stroke();
            }
            
            Connections {
                target: monitorCircle.canvas
                function onPercentageChanged() {
                    displayCanvas.requestPaint();
                }
            }
        }
        
        Column {
            anchors.centerIn: parent
            Text {
                text: monitorCircle.valueText
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: monitorCircle.config.fontFamilyMono
                font.pixelSize: Math.round(13 * monitorCircle.scale)
                font.weight: Font.Bold
                color: monitorCircle.config.colors.fg
            }
        }
    }
    
    Text {
        text: monitorCircle.label
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: monitorCircle.config.fontFamily
        font.pixelSize: Math.round(11 * monitorCircle.scale)
        color: monitorCircle.config.colors.fgDim
    }
}
