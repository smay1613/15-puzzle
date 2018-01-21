import QtQuick 2.5

Item {
    property var view

    Row {
        id: _headerRow

        anchors.fill: parent

        spacing: 5

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
            }
        }

        Column {
            width: _headerRow.width / 2
            height: _headerRow.height

            Text {
                id: movesCounterText

                height: parent.height
                width: parent.width

                text: "Moves: " + view.movesCount

                elide: Text.ElideMiddle

                font.pointSize: _headerRow.height

                fontSizeMode: Text.Fit
            }
        }
    }
}
