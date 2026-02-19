import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.core
import qs.services
import qs.components.widgets

PanelWindow {
    id: root 
    required property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: 35
    color: Appearance.bg
    exclusiveZone: implicitHeight 

    // ==========================================
    // LEFT SECTION
    // ==========================================
    Row {
        id: leftSection
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 12
        spacing: 12

        WorkspacesWidget {
            targetScreen: root.modelData
            anchors.verticalCenter: parent.verticalCenter
        }
        
    }

    // ==========================================
    // CENTER SECTION 
    // ==========================================
    Item {
        id: centerSection
        anchors.centerIn: parent
        
        width: activeWindowTitle.implicitWidth 
        height: parent.height

        Text {
            id: activeWindowTitle
            anchors.centerIn: parent
            text: Hyprland.activeToplevel?.title ?? "Hyprland"
            color: Appearance.fg
            font.pixelSize: 14
        }
    }

    // ==========================================
    // RIGHT SECTION 
    // ==========================================
    Row {
        id: rightSection
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 12
        spacing: 12

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: KeyboardService.currentLayoutCode
            color: Appearance.fg
            font.pixelSize: 14
            font.bold: true
        }

        ClockWidget {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
