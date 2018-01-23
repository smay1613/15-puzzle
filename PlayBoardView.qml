import QtQuick 2.5

GridView {
    id: _playBoardGrid

    signal victory()
    signal moveDone()

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
                    moveDone();
                }
                if (_playBoardGrid.model.isVictory()) {
                    victory();
                }
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
