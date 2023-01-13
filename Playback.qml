import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root
    required property MediaPlayer mediaPlayer
//  mediaPlayerState is an integer value to indicate the state of the vedio while vedio moves forward and backward
    property int mediaPlayerState: mediaPlayer.playbackState


    height: frame.height
    opacity: 1

   // Specify the max duration to go
    Behavior on opacity { NumberAnimation { duration: 300 }}

    // this fuction simplely says check hoverd or mediaPlayerState are not equal
    // PlayingState or no vedio to play then opacity = 1
    function updateOpacity() {
        if (Qt.platform.os == "android" || Qt.platform.os == "ios")
            return;

        if (playbackControlHover.hovered || mediaPlayerState != MediaPlayer.PlayingState || !mediaPlayer.hasVideo)
            root.opacity = 1;
        else
            root.opacity = 1;
    }

 // check if playState changed connect the singal with updateOpacity slot to update changes
 // check onHasVideoChanged changed connect the singal with updateOpacity slot to update changes
    Connections {
        target: mediaPlayer
        function onPlaybackStateChanged() { updateOpacity() }
        function onHasVideoChanged() { updateOpacity() }
    }

//  HoverHandler handles mouse changes and send signals to updateOpacity
    HoverHandler {
        id: playbackControlHover
        margin: 50
        onHoveredChanged: updateOpacity()
    }

 // Frame components (objects)
    Frame {
        id: frame
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        background: Rectangle {
            color: "#F5F5F5"
        }

        ColumnLayout {
            id: playbackControlPanel
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

 //        invoke Playback2.qml and pass properties
            Playback2 {
                Layout.fillWidth: true
                mediaPlayer: root.mediaPlayer
            }

            RowLayout {
                id: playerButtons

                Layout.fillWidth: true
                Item {
                    Layout.fillWidth: true
                }

                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    id: controlButtons

                    RoundButton {
                        id: pauseButton
                        radius: 50.0
                        text: "\u2016";
                        onClicked: mediaPlayer.pause()
                    }

                    RoundButton {
                        id: playButton
                        radius: 50.0
                        text: "\u25B6";
                        onClicked: mediaPlayer.play()
                    }

                    RoundButton {
                        id: stopButton
                        radius: 50.0
                        text: "\u25A0";
                        onClicked: mediaPlayer.stop()
                    }
                }

                Item {
                    Layout.fillWidth: true
                }
            }
        }
    }

    states: [
 //     if the vedio is playing enable two buttons play and stop
        State {
            name: "playing"
            when: mediaPlayerState == MediaPlayer.PlayingState
            PropertyChanges { target: pauseButton; visible: true}
            PropertyChanges { target: playButton; visible: false}
            PropertyChanges { target: stopButton; visible: true}
        },
//      if the vedio is stopped enable only play button
        State {
            name: "stopped"
            when: mediaPlayerState == MediaPlayer.StoppedState
            PropertyChanges { target: pauseButton; visible: false}
            PropertyChanges { target: playButton; visible: true}
            PropertyChanges { target: stopButton; visible: false}
        },

//     if the vedio is playing enable two buttons play and stop
        State {
            name: "paused"
            when: mediaPlayerState == MediaPlayer.PausedState
            PropertyChanges { target: pauseButton; visible: false}
            PropertyChanges { target: playButton; visible: true}
            PropertyChanges { target: stopButton; visible: true}
        }
    ]

}

