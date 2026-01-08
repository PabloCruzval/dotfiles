pragma Singleton
import QtQuick

Item {
    readonly property color _bg: "#213448"
    readonly property color _fg: "#EAE0CF"
    readonly property color _accent: "#94B4C1"
    readonly property color _error: "#9E3B3B"

    readonly property color background: _bg
    readonly property color text: _fg
    readonly property color highlight: _accent
    readonly property color danger: _error

    function withOpacity(clr, alpha) {
        return Qt.rgba(clr.r, clr.g, clr.b, alpha)
    }
}
