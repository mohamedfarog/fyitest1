
// maim.qml is first file that is executed by main.cpp
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtMultimedia


// Window object initialize the main Farme including all components inside
Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("FYI TEST")

    property alias source: mediaPlayer.source

//     MediaPlayes is a child class of QObject to help with media play
//     such as vedio and aduio, we can use the whole object or oly use the vedio player function
    MediaPlayer {
        id: mediaPlayer
        videoOutput: videoOutput
        onErrorOccurred: { mediaErrorText.text = mediaPlayer.errorString; mediaError.open() }
    }

    // MenuBar1 file properties initialization
    MenuBar1 {
        id: menuBar
        anchors.left: parent.left
        anchors.right: parent.right
        visible: !videoOutput.fullScreen
        mediaPlayer: mediaPlayer
        videoOutput: videoOutput
    }
 // An Object that Render video view
    VideoOutput {
        id: videoOutput
        property bool fullScreen: false
        anchors.top: fullScreen ? parent.top : menuBar.bottom
        anchors.bottom: playbackControl.top
        anchors.left: parent.left
        anchors.right: parent.right

        TapHandler {
            onDoubleTapped: {
                parent.fullScreen ?  showNormal() : showFullScreen()
                parent.fullScreen = !parent.fullScreen
            }
        }
    }

    // Playback file properties initialization
    Playback {
        id: playbackControl
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        mediaPlayer: mediaPlayer
    }
}
