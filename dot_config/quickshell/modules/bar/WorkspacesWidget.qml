import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../../" as Root

ColumnLayout {
    required property int workspaceOffset
    
    spacing: Root.Config.workspaceSpacing

    Repeater {
        model: Root.Config.workspacesPerMonitor

        Rectangle {
            required property int index
            readonly property int workspaceId: workspaceOffset + index + 1
            readonly property var workspace: Hyprland.workspaces.values.find(w => w.id === workspaceId)
            readonly property bool isActive: Hyprland.focusedWorkspace?.id === workspaceId
            
            Layout.alignment: Qt.AlignHCenter
            implicitWidth: Root.Config.workspaceSize
            implicitHeight: Root.Config.workspaceSize
            radius: Root.Config.workspaceSize / 2
            color: isActive ? Root.Config.workspaceActive : (workspace ? Root.Config.workspaceOccupied : Root.Config.workspaceInactive)

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + parent.workspaceId)
            }
        }
    }
}
