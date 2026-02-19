import QtQuick
import qs.core

Rectangle {
    property bool isActive: false
    property bool isOccupied: false

    signal clicked()

    width: 12
    height: 12
    radius: Appearance.radius

    color: {
        if (isActive) return Appearance.primary;
        if (isOccupied) return Appearance.occupiedWs;
        return Appearance.unusedWs;
    }

    Behavior on color { ColorAnimation { duration: 150 } }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: parent.clicked()
    }
}
