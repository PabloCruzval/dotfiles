import Quickshell.Services.SystemTray
import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../" as Root

ColumnLayout {
    spacing: Root.Config.workspaceSpacing
    visible: repeater.count > 0

    Repeater {
        id: repeater
        model: SystemTray.items

        Item {
            id: trayItemContainer
            required property SystemTrayItem modelData
            
            Layout.alignment: Qt.AlignHCenter
            implicitWidth: Root.Config.workspaceSize * 2
            implicitHeight: Root.Config.workspaceSize * 2

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: event => {
                    if (event.button === Qt.LeftButton) {
                        trayItemContainer.modelData.activate();
                    } else {
                        if (trayItemContainer.modelData.menu) {
                            menuAnchor.open();
                        } else {
                            trayItemContainer.modelData.secondaryActivate();
                        }
                    }
                }

                Image {
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    source: trayItemContainer.modelData.icon
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

            QsMenuAnchor {
                id: menuAnchor
                menu: trayItemContainer.modelData.menu
                
                anchor {
                    window: QsWindow.window
                    item: trayItemContainer
                    rect: Qt.rect(0, 0, trayItemContainer.width, trayItemContainer.height)
                }
            }
        }
    }
}
