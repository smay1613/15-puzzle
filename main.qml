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
            width: root.width

            spacing: 5

            Rectangle {
                width: _headerRow.width / 2
                height: _headerRow.height

                Text {
                    id: timeCounterText

                    height: parent.height
                    width: parent.width

                    text: "Time: " + _playBoard.timeCountInSeconds + ":" + _playBoard.timeCountInMinutes

                    elide: Text.ElideMiddle

                    font.pointSize: _headerRow.height

                    fontSizeMode: Text.Fit
                }
            }
            Rectangle {
                width: _headerRow.width / 2
                height: _headerRow.height

                Text {
                    id: movesCounterText

                    height: parent.height
                    width: parent.width

                    anchors.centerIn: parent

                    text: "Moves: " + _playBoard.movesCount

                    elide: Text.ElideMiddle

                    font.pointSize: _headerRow.height

                    fontSizeMode: Text.Fit
                }
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

