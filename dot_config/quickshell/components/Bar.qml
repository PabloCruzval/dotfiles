import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.services
import qs.core

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

    Item {
        id: leftSection
		anchors {
			left: parent.left
            right: centerSection.left
            top: parent.top
            bottom: parent.bottom
        }
        clip: true

        WorkspacesWidget {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
			anchors.leftMargin: 12
			targetScreen: root.modelData
        }
    }

    Item {
        id: rightSection
        anchors {
            left: centerSection.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        clip: true

        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
			anchors.rightMargin: 12
			spacing: 12
			ClockWidget {}
            Text {
                text: KeyboardService.currentLayoutCode
                color: Appearance.fg
                font.pixelSize: 14
                font.bold: true
            }
        }
    }
}
