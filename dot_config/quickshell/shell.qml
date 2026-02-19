import QtQuick
import Quickshell
import qs.components

ShellRoot {
    Variants {
        model: Quickshell.screens
		Scope {
			id: sp_bar
			required property var modelData
            Bar {
                modelData: sp_bar.modelData
            }
        }
    }
}
