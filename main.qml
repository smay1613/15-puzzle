import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: root

    width: 800
    height: 800
    visible: true

    PlayBoardView {
        id: _playBoard

        property int timeCountInSeconds: 0
        property int timeCountInMinutes: 0
        property int movesCount: 0

        function openVictoryMessage() {
            _loader.source = "VictoryMessage.qml";
            _loader.item.width = Qt.binding(function() { return width; });
            _loader.item.height = Qt.binding(function() { return height; });
            _loader.item.messageText = "You won! Start a new game?";
            _loader.item.open();
            _loader.item.accepted.connect(model.shufflePlayBoard);
        }

        function openContextMenu() {
            _loader.source = "ContextMenu.qml";
            _loader.item.popup();
            _loader.item.itemClicked.connect(model.shufflePlayBoard);
        }

        anchors.fill: parent

        cellWidth: width / model.boardSize
        cellHeight: height / model.boardSize - headerItem.height / model.boardSize

        interactive: false
        model: myModel

        header: Row {
            id: _headerRow

            height: root.height / 12
            spacing: width * 0.2

            Text {
                id: movesCounterText

                height: _headerRow.height
                width: text.length * 50

                text: "Moves: " + _playBoard.movesCount

                font.pointSize: _headerRow.height
                minimumPointSize: 1

                fontSizeMode: Text.Fit
                Component.onCompleted: {console.log(text.length)}
            }

            Text {
                id: timeCounterText

                height: _headerRow.height

                text: "Time: " + _playBoard.timeCountInSeconds + ":" + _playBoard.timeCountInMinutes

                font.pointSize: _headerRow.height
                minimumPointSize: 1

                fontSizeMode: Text.Fit
            }
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

