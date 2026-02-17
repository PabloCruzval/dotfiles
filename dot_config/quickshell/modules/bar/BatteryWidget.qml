import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../../" as Root

ColumnLayout {
    spacing: 0

    Text {
        id: batteryText
        Layout.alignment: Qt.AlignHCenter
        text: "-%"
        color: Root.Config.primary
        font {
            family: Root.Config.fontFamily
            pixelSize: Root.Config.fontSizeClock
            bold: true
        }
        horizontalAlignment: Text.AlignHCenter
    }

    Process {
        id: batteryProcess
        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const capacity = data.trim();
                batteryText.text = capacity + "%";
            }
        }
    }

    // Timer to update battery level periodically
    Timer {
        interval: 5000  // Update every 5 seconds
        running: true
        repeat: true
        onTriggered: {
            batteryProcess.running = true;
        }
    }
}
