import QtQuick
import QtQuick.Window

Window {
    id: petWindow

    width: 300
    height: 300

    visible: true

    flags: Qt.FramelessWindowHint
           | Qt.WindowStaysOnTopHint

    color: "transparent"

    Rectangle {
        id: character

        width: 150
        height: 150

        anchors.centerIn: parent

        radius: width / 2
        color: "#66CCFF"

        border.width: 3
        border.color: "#FFFFFF"

        Text {
            anchors.centerIn: parent

            text: "Hello!"
            color: "#FFFFFF"
            font.pixelSize: 24
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent

            cursorShape: Qt.OpenHandCursor

            onPressed: function(mouse) {
                cursorShape = Qt.ClosedHandCursor
                petWindow.startSystemMove()
            }

            onReleased: {
                cursorShape = Qt.OpenHandCursor
            }
        }
    }
}
