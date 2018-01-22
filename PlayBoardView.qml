import QtQuick 2.5

GridView {
    id: _playBoardGrid

    property alias timer: _timerCounter
    property int timeCountInSeconds: 0
    property int timeCountInMinutes: 0
    property int movesCount: 0

    signal victory()

    function clearScores() {
        timeCountInSeconds = 0;
        timeCountInMinutes = 0;
        movesCount = 0;
    }

    delegate: Item {
        id: _cell

        width: _playBoardGrid.cellWidth
        height: _playBoardGrid.cellHeight

        Tile {
            width: _cell.width - 6
            height: _cell.height - 6

            anchors.centerIn: _cell

            visible: value != _playBoardGrid.model.boardSize * _playBoardGrid.model.boardSize - 1

            onCellClicked: {
                if (_playBoardGrid.model.playBoardMakeMove(index)) {
                    ++movesCount;
                    _timerCounter.start();
                }
                if (!_playBoardGrid.model.isVictory()) {
                    victory();
                }
            }
        }
    }

    Timer {
        id: _timerCounter
        interval: 1000
        running: _playBoardGrid.movesCount > 0
        repeat: true

        onTriggered: {
            if (_playBoardGrid.timeCountInSeconds >= 60) {
                ++_playBoardGrid.timeCountInMinutes;
                _playBoardGrid.timeCountInSeconds = 0;
            } else {
                ++_playBoardGrid.timeCountInSeconds;
            }
        }
    }

    move: Transition {
        NumberAnimation {
            properties: "x, y"
            duration: 400
            easing.type: Easing.InOutExpo
        }
    }
}
