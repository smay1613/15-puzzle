import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: _cellRectangle

    signal cellClicked()

    color: "lightgreen"
    border {
        color: "black"
        width: 3
    }

    radius: 5

    RectangularGlow {
        anchors.fill: _cellRectangle

        glowRadius: 5
        spread: 0.05

        color: "lightgreen"

        cornerRadius: _cellRectangle.radius + glowRadius
    }



    Text {
        anchors.centerIn: parent

        text: value + 1
        font.pointSize: Math.min(_cellRectangle.width, _cellRectangle.height) * 0.6
    }

    MouseArea {
        id: _mouseArea
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton
        onClicked: {
            cellClicked();
        }
    }
}




