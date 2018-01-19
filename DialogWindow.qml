import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
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
}
