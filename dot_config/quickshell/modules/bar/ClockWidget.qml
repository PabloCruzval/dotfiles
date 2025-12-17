import QtQuick
import QtQuick.Layouts
import "../../" as Root

ColumnLayout {
    spacing: 0

    Repeater {
        model: Qt.formatDateTime(new Date(), "hh:mm:AP").split(":")

        Text {
            required property string modelData
            
            Layout.alignment: Qt.AlignHCenter
            text: modelData
            color: Root.Config.primary
            font {
                family: Root.Config.fontFamily
                pixelSize: modelData.match(/[AP]M/) ? Root.Config.fontSizeClockSmall : Root.Config.fontSizeClock
                bold: true
            }
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            const time = Qt.formatDateTime(new Date(), "hh:mm:AP").split(":");
            for (let i = 0; i < 3; i++) {
                if (i < parent.children.length) {
                    const item = parent.children[i];
                    if (item && item.text !== undefined) {
                        item.text = time[i];
                    }
                }
            }
        }
    }
}
