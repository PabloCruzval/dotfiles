pragma Singleton
import QtQuick 
import Quickshell
import qs.services

Singleton {
	id: appearance

    property var p: (typeof ThemeService !== "undefined" && ThemeService.palette) ? ThemeService.palette : {
        "bg": "#191D1C", 
        "fg": "#CCCDBC", 
        "primary": "#4DAB4E",
        "surface": "#313244", 
        "occupiedWs": "#A1AF89", 
        "unusedWs": "#202824"
	}

    property color bg: ThemeService.palette.bg
    property color fg: ThemeService.palette.fg
    property color primary: ThemeService.palette.primary
    property color surface: ThemeService.palette.surface
    property color occupiedWs: ThemeService.palette.occupiedWs
    property color unusedWs: ThemeService.palette.unusedWs
    
    property int radius: 8
    property int barHeight: 35
}
