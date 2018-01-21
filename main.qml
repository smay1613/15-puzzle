import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: root

    width: 800
    height: 800
    visible: true

    PlayBoardView {
        id: _playBoard

        function openVictoryMessage() {
            _loader.source = "VictoryMessage.qml";
            _loader.item.width = Qt.binding(function() { return width; });
            _loader.item.height = Qt.binding(function() { return height; });
            _loader.item.messageText = "You won! Start a new game?";
            _loader.item.open();
            _loader.item.accepted.connect(model.shufflePlayBoard);
            _loader.item.accepted.connect(clearScores);
            timer.stop();
        }

        function openContextMenu() {
            _loader.source = "ContextMenu.qml";
            _loader.item.popup();
            _loader.item.itemClicked.connect(model.shufflePlayBoard);
            _loader.item.itemClicked.connect(clearScores);
        }

        anchors.fill: parent

        cellWidth: width / model.boardSize
        cellHeight: height / model.boardSize - headerItem.height / model.boardSize

        interactive: false
        model: myModel

        header: ScoreBoard {
            id: _scoreBoard

            height: root.height / 12
            width: root.width

            view: _playBoard
        }

        MouseArea {
            anchors.fill: parent

            propagateComposedEvents: true
            acceptedButtons: Qt.RightButton

            onClicked: {
                mouse.accepted = false;
                _playBoard.openContextMenu();
            }
        }

        onVictory: {
            openVictoryMessage();
        }
    }

    Loader {
        id: _loader

        anchors.fill: parent
    }
}

