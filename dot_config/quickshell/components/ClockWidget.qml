import QtQuick
import qs.core
import qs.services

Row {
    spacing: 8
    
    Text {
        text: DateTime.time
        color: Appearance.fg
        font.pixelSize: 14
        font.bold: true
    }
}
