import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property string message

    RectangularGlow {
        anchors.fill: _popupContainerRectangle

        glowRadius: 10
        spread: 0.1

        color: "white"

        cornerRadius: _popupContainerRectangle.radius + glowRadius
    }

    Rectangle {
        id: _popupContainerRectangle

        anchors.fill: parent

        radius: 5

        color: "white"
    }

    Text {
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: parent.height / 16
            bottomMargin: parent.height / 16
        }

        text: message
        font.pointSize: Math.min(parent.height, parent.width) / 12
    }
}
