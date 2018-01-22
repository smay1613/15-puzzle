import QtQuick 2.5
import Qt.labs.controls 1.0

Popup {
    id: _victoryPopup

    property string messageText

    signal accepted()
    signal declined()

    bottomPadding: height / 3
    topPadding: height / 3
    rightPadding: width / 6
    leftPadding: width / 6

    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose

    opacity: 0.9

    background: Rectangle {
        id: _backgroundRectangle
        color: "black"
    }

    contentItem: DialogWindow {
        id: _dialogWindow

        anchors.centerIn: _backgroundRectangle

        message: messageText

        Button {
            width: _dialogWindow.width / 4
            height: _dialogWindow.height / 6

            anchors {
                horizontalCenter: _dialogWindow.horizontalCenter
                horizontalCenterOffset: -width
                bottom: _dialogWindow.bottom
                bottomMargin: height / 2
            }

            text: "Yes"
            font.pointSize: Math.min(_dialogWindow.height, _dialogWindow.width) / 12

            onClicked: {
                _victoryPopup.close();
                _victoryPopup.accepted();
            }
        }

        Button {
            width: _dialogWindow.width / 4
            height: _dialogWindow.height / 6

            anchors {
                horizontalCenter: _dialogWindow.horizontalCenter
                horizontalCenterOffset: width
                bottom: _dialogWindow.bottom
                bottomMargin: height / 2
            }

            text: "No "
            font.pointSize: Math.min(_dialogWindow.height, _dialogWindow.width) / 12

            onClicked: {
                _victoryPopup.close();
                _victoryPopup.declined();
            }
        }
    }
}

