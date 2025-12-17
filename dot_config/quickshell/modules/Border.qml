import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import "../" as Root

PanelWindow {
    required property var monitor
    
    screen: monitor
    anchors.top: true
    anchors.left: true
    anchors.bottom: true
    anchors.right: true
    
    visible: true
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    mask: Region {}

    Rectangle {
        anchors.fill: parent
        color: Root.Config.background
        visible: true

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: borderMask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: borderMask
        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            anchors.margins: Root.Config.borderThickness
            anchors.leftMargin: Root.Config.barWidth
            radius: Root.Config.borderRounding
        }
    }
}
