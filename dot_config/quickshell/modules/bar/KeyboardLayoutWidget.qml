import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import "../../" as Root

Text {
    id: root
    
    property string layout: "??"
    
    Component.onCompleted: updateLayout()
    
    function updateLayout() {
        process.running = true;
    }
    
    Connections {
        target: Hyprland
        
        function onRawEvent(event) {
            // Detectar evento de cambio de layout
            if (event.name === "activelayout") {
                root.updateLayout();
            }
        }
    }
    
    Process {
        id: process
        command: ["hyprctl", "devices", "-j"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(text);
                    const keyboards = data.keyboards || [];
                    const mainKb = keyboards.find(kb => kb.main) || keyboards[0];
                    
                    if (mainKb && mainKb.active_keymap) {
                        const keymap = mainKb.active_keymap;
                        // Extraer código: "Spanish" -> "ES", "English (US)" -> "US"
                        const match = keymap.match(/\(([A-Z]{2})\)/);
                        if (match) {
                            root.layout = match[1];
                        } else {
                            root.layout = keymap.substring(0, 2).toUpperCase();
                        }
                    }
                } catch (e) {
                    console.error("Failed to parse keyboard layout:", e);
                }
            }
        }
    }
    
    text: layout.split("").join("\n")
    color: Root.Config.secondary
    font {
        family: Root.Config.fontFamily
        pixelSize: Root.Config.fontSizeWindow
        bold: true
    }
    horizontalAlignment: Text.AlignHCenter
    lineHeight: 1.2
}
