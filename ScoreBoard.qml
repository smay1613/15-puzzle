import QtQuick 2.5

Item {
    property var view

    Row {
        id: _headerRow

        anchors.fill: parent

        Column {
            width: _headerRow.width / 2
            height: _headerRow.height

            Text {
                id: timeCounterText

                height: parent.height
                width: parent.width

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text: "Time: " + view.timeCountInMinutes + "m:" + view.timeCountInSeconds + "s"

                font.pointSize: _headerRow.height

                fontSizeMode: Text.Fit

                wrapMode: Text.WordWrap

            }
        }

        Column {
            width: _headerRow.width / 2
            height: _headerRow.height

            Text {
                id: movesCounterText

                height: parent.height
                width: parent.width

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text: "Moves: " + view.movesCount

                font.pointSize: _headerRow.height

                fontSizeMode: Text.Fit

                wrapMode: Text.WordWrap
            }
        }
    }

    Image {
        source: "separator.png"
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.bottom
            verticalCenterOffset: -parent.height / 50
        }
    }
}
