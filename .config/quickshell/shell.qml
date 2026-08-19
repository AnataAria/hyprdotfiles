import QtQuick
import Quickshell

ShellRoot {
    Instantiator {
        model: Quickshell.screens

        delegate: Bar {
            required property var modelData
            screen: modelData
        }
    }
}
