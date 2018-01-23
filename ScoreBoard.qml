import QtQuick 2.5

Item {
    property var timer: _timerCounter
    property int movesCount: 0

    function clearScores() {
        _timerCounter.timeCountInSeconds = 0;
        _timerCounter.timeCountInMinutes = 0;
        movesCount = 0;
    }

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

                text: "Time: " + _timerCounter.timeCountInMinutes + "m:" + _timerCounter.timeCountInSeconds + "s"

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

                text: "Moves: " + movesCount

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

    Timer {
        id: _timerCounter

        property int timeCountInSeconds: 0
        property int timeCountInMinutes: 0

        interval: 1000
        running: movesCount > 0
        repeat: true

        onTriggered: {
            if (timeCountInSeconds >= 60) {
                ++timeCountInMinutes;
                timeCountInSeconds = 0;
            } else {
                ++timeCountInSeconds;
            }
        }
    }
}
