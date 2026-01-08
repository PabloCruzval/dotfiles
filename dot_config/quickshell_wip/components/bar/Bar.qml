import Quickshell
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import qs.services
import "../../utils/text.js" as TextUtils
import "../../ui"

PanelWindow {
	id: bar
	required property var modelData
	required property int monitorIndex
    screen: modelData
    color: Theme.background

    anchors {
        top: true
        right: true
        bottom: true
    }

    implicitWidth: 30
	ColumnLayout {
        anchors.fill: parent

		Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            Rectangle {
                id: window_name_background
                anchors.centerIn: parent
                Layout.alignment: Qt.AlignCenter
                radius: 10
                color: Theme.highlight
                Text {
                    id: window_name
                    color: Theme.text
                    readonly property string windowTitle: Hyprland.activeToplevel?.title ?? "Desktop"
                    anchors.centerIn: parent
                    anchors.margins: 5
                    horizontalAlignment: Text.AlignHCenter
                    text: TextUtils.verticalSplit(windowTitle, 12)
                }
                width: window_name.width + 2 * window_name.anchors.margins
                height: window_name.height + 2 * window_name.anchors.margins
            }
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            ColumnLayout {
                width: parent.width
                Text {
                    color: Theme.text
                    Layout.alignment: Qt.AlignHCenter
                    text: TextUtils.splitTime(Time.time)
                }
            }
        }
    }
}
