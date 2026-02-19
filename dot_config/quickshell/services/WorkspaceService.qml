pragma Singleton
import QtQuick
import Quickshell.Hyprland
import qs.core

QtObject {
    id: workspaceService

    function getIdsForScreen(targetScreen) {
        if (!targetScreen) return [];
        if (Config.isLaptop) return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        
        return (targetScreen.name === Config.primaryMonitor) 
            ? [1, 2, 3, 4, 5] 
            : [6, 7, 8, 9, 10];
    }

    function switchTo(workspaceId) {
        Hyprland.dispatch(`workspace ${workspaceId}`);
    }
}
