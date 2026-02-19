import QtQuick
import Quickshell.Hyprland
import qs.services
import qs.core

Row {
    id: root 
    spacing: 8
    
    property var targetScreen
    readonly property var monitorData: Hyprland.monitorFor(root.targetScreen)

    Repeater {
        model: root.targetScreen ? WorkspaceService.getIdsForScreen(root.targetScreen) : []
        WorkspaceDot {
            isActive: root.monitorData?.activeWorkspace?.id === modelData
            isOccupied: Hyprland.workspaces.values.some(ws => ws.id === modelData)

            onClicked: WorkspaceService.switchTo(modelData)
        }
    }
}
