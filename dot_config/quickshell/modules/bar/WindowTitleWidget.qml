import Quickshell.Hyprland
import QtQuick
import "../../" as Root

Text {
    readonly property string windowTitle: Hyprland.activeToplevel?.title ?? "Desktop"
    readonly property string truncated: windowTitle.length > 12 
        ? windowTitle.substring(0, 12) + "…" 
        : windowTitle

    text: truncated.split("").join("\n")
    color: Root.Config.primary
    font {
        family: Root.Config.fontFamily
        pixelSize: Root.Config.fontSizeWindow
        bold: true
    }
    horizontalAlignment: Text.AlignHCenter
    lineHeight: 1.2
}
