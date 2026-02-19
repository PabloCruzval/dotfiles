pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    property string time: ""
    property string date: ""

    function update() {
        const now = new Date();
        time = now.toLocaleTimeString("es-CL", { hour: '2-digit', minute: '2-digit', hour12: true});
        date = now.toLocaleDateString("es-CL", { day: '2-digit', month: 'short' });
    }

    property var timer: Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.update()
    }
}
