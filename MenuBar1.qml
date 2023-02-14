
import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Fusion as FyiTest

Item {
    id: root
    required property MediaPlayer mediaPlayer
    required property VideoOutput videoOutput
    property color bgColor: "#87CEEB"

    height: menuBar.height

//   File Dialog enbles to select file from local with the help of QtQick.Dialogs
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            mediaPlayer.stop()
//         You can pass exsiting file directory (source: "file://video.webm") instead of fileDialog.currentFile
//           mediaPlayer.source = ":/../../Downloads/test.mp4"
            mediaPlayer.source = fileDialog.currentFile
            mediaPlayer.play()
        }
    }

//      Menu Bar to upload mp4 file from device
      FyiTest.MenuBar {
        id: menuBar
        anchors.left: parent.left
        anchors.right: parent.right
        background: Rectangle {
            color: bgColor
        }
        FyiTest.Menu {

            title: qsTr("&Load Vedio")
            FyiTest.Action {
                text: qsTr("&Open")
                onTriggered: fileDialog.open()
            }
        }
        }

    }

