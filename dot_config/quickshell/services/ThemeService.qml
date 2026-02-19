pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var palette: {
        "bg": "#191D1C",
        "fg": "#CCCDBC",
        "primary": "#4DAB4E",
        "surface": "#313244",
        "occupiedWs": "#A1AF89",
        "unusedWs": "#202824"
    }

    // 1. CARGA INICIAL (Solo se ejecuta al encender la PC o reiniciar Quickshell)
    // Usamos tu ruta absoluta para evitar que QML se confunda con las tildes
    readonly property string absolutePath: "/home/nyx/.cache/theme/current.json"

    Process {
        id: initialLoad
        command: ["cat", absolutePath]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let newTheme = JSON.parse(text);
                    root.palette = newTheme.colors;
                } catch(e) {
                    console.log("Aviso: No se pudo cargar el tema inicial. Usando default.");
                }
            }
        }
    }

    Component.onCompleted: initialLoad.running = true

    // 2. ACTUALIZACIÓN DINÁMICA (Arquitectura IPC por Payload)
    // El orquestador envía el JSON directamente como un string. ¡Cero latencia de disco!
    property IpcHandler ipc: IpcHandler {
        target: "theme" 
        function applyColors(payload: string) {
            try {
                let newTheme = JSON.parse(payload);
                root.palette = newTheme.colors;
            } catch(e) {
                console.error("Error parseando el payload IPC:", e);
            }
        }
    }
}
