import Quickshell
import QtQuick
import Quickshell.Hyprland
import "./components/bar/" 

Scope {
    id: root

    readonly property int workspacesPerMonitor: 5
    Variants {
        model: Quickshell.screens

		Scope {
			id: sp_bar
			required property var modelData
            readonly property int monitorIndex: {
                const totalScreens = Quickshell.screens.length;
                const currentIndex = Quickshell.screens.indexOf(modelData);
                return totalScreens - 1 - currentIndex;
            }
			Bar{
				modelData: sp_bar.modelData
				monitorIndex: sp_bar.monitorIndex
			}
        }
    }
}
