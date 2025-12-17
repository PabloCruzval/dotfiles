//@ pragma UseQApplication

import Quickshell
import QtQuick
import "modules" as Modules

Scope {
    Variants {
        model: Quickshell.screens

        Scope {
            id: scopeItem
            required property var modelData
            
            readonly property int monitorIndex: {
                const totalScreens = Quickshell.screens.length;
                const currentIndex = Quickshell.screens.indexOf(modelData);
                return totalScreens - 1 - currentIndex;
            }
            readonly property int workspaceOffset: monitorIndex * Config.workspacesPerMonitor

            Modules.Border {
                monitor: scopeItem.modelData
            }

            Modules.Bar {
                monitor: scopeItem.modelData
                workspaceOffset: scopeItem.workspaceOffset
            }
        }
    }
}
