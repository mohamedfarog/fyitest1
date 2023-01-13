
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root
    required property MediaPlayer mediaPlayer
    required property VideoOutput videoOutput
    height: menuBar.height

    //File Dialog enbles to select file from local with the help of QtQick.Dialogs
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            mediaPlayer.stop()
            //You can pass exsiting file directory (source: "file://video.webm") instead of fileDialog.currentFile
            mediaPlayer.source = fileDialog.currentFile
            mediaPlayer.play()
        }
    }

    // Menu Bar to upload mp4 file from device
    MenuBar {
        id: menuBar
        anchors.left: parent.left
        anchors.right: parent.right
        background: Rectangle {
            color: "#87CEEB"
        }

        Menu {

            title: qsTr("&Load Vedio")
            Action {
                text: qsTr("&Open")
                onTriggered: fileDialog.open()
            }
        }
        }

    }

