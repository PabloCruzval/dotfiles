pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property var config: ({
        bar: {
            width: 50,
            padding: 16,
            background: "#2E3440",
            primary: "#D8DEE9"
        },
        fonts: {
            family: "Ubuntu Nerd Font",
            size: {
                clock: 14,
                clockSmall: 10,
                window: 11
            }
        },
        workspaces: {
            perMonitor: 5,
            size: 8,
            spacing: 8,
            activeColor: "#88C0D0",
            occupiedColor: "#81A1C1",
            inactiveColor: "#4C566A"
        },
        border: {
            thickness: 10,
            rounding: 25,
            color: "#81A1C1"
        }
    })

    // Bar settings
    readonly property int barWidth: config.bar.width
    readonly property int barPadding: config.bar.padding
    readonly property string background: config.bar.background
    readonly property string primary: config.bar.primary
    readonly property string secondary: config.border.color

    // Font settings
    readonly property string fontFamily: config.fonts.family
    readonly property int fontSizeClock: config.fonts.size.clock
    readonly property int fontSizeClockSmall: config.fonts.size.clockSmall
    readonly property int fontSizeWindow: config.fonts.size.window

    // Workspace settings
    readonly property int workspacesPerMonitor: config.workspaces.perMonitor
    readonly property int workspaceSize: config.workspaces.size
    readonly property int workspaceSpacing: config.workspaces.spacing
    readonly property string workspaceActive: config.workspaces.activeColor
    readonly property string workspaceOccupied: config.workspaces.occupiedColor
    readonly property string workspaceInactive: config.workspaces.inactiveColor

    // Border settings
    readonly property int borderThickness: config.border.thickness
    readonly property int borderRounding: config.border.rounding
    readonly property string borderColor: config.border.color

    FileView {
        path: "/home/nyx/.config/quickshell/config.json"
        
        onLoaded: {
            try {
                const parsed = JSON.parse(text());
                root.config = parsed;
                console.log("Config loaded successfully from JSON");
            } catch (e) {
                console.error("Failed to parse config.json:", e);
            }
        }
    }
}
