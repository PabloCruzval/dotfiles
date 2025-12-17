import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../" as Root
import "bar" as BarComponents

PanelWindow {
    id: bar
    
    required property var monitor
    required property int workspaceOffset
    
    screen: monitor
    anchors.top: true
    anchors.left: true
    anchors.bottom: true
    
    visible: true
    implicitWidth: Root.Config.barWidth
    color: Root.Config.background
    WlrLayershell.layer: WlrLayer.Top
    exclusiveZone: Root.Config.barWidth

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Top section: Clock and Workspaces
        BarComponents.ClockWidget {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.topMargin: Root.Config.barPadding
        }

        BarComponents.WorkspacesWidget {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.topMargin: Root.Config.barPadding
            workspaceOffset: bar.workspaceOffset
        }

        Item { Layout.fillHeight: true }

        // Middle section: Window Title
        BarComponents.WindowTitleWidget {
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: bar.implicitWidth - Root.Config.barPadding
        }

        Item { Layout.fillHeight: true }

        // Bottom section: Tray and Keyboard Layout
        BarComponents.TrayWidget {
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.bottomMargin: Root.Config.barPadding
        }

        BarComponents.KeyboardLayoutWidget {
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.bottomMargin: Root.Config.barPadding
        }
    }
}
