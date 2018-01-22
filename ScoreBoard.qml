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

                text: "Time: " + view.timeCountInMinutes + "m:" + view.timeCountInSeconds + "s"

                elide: Text.ElideMiddle

                font.pointSize: _headerRow.height

                fontSizeMode: Text.Fit

                wrapMode: Text.WordWrap

                verticalAlignment: Text.AlignVCenter
            }
        }

        Column {
            width: _headerRow.width / 2
            height: _headerRow.height
            anchors.right: parent.right
            Text {
                id: movesCounterText

                height: parent.height
                width: parent.width

                text: "Moves: " + view.movesCount

                elide: Text.ElideMiddle

                font.pointSize: _headerRow.height

                fontSizeMode: Text.Fit

                wrapMode: Text.WordWrap

                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
