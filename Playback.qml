import QtQuick
import QtQuick.Layouts
import QtMultimedia


Item {
    id: root
    required property MediaPlayer mediaPlayer
    property int mediaPlayerState: mediaPlayer.playbackState


    property int buttonHeight: 40
    property int buttonWidth: 50
    property color borderColor: "white"
    property color buttonColor: "#87CEEB"


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
    Item  {
        id: frame
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 300
        height: 100

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

                    Rectangle {
                        id: stopButton
                        radius: 50
                        smooth: true
                        border{color: "red"; width: 3}
                        width: buttonWidth; height: buttonHeight

                        Text{
                            id: buttonLabel2
                            anchors.centerIn: parent
                            text: "Stop"
                        }
                        MouseArea{
                            id: buttonMouseArea2
                            anchors.fill: parent    //stretch the area to the parent's dimension
                            onClicked:  mediaPlayer.stop()
                            hoverEnabled: true
                        }
                        color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor
                    }
                    Rectangle {
                        id: pauseButton
                        radius: 50
                        smooth: true
                        border{color: "orange"; width: 3}
                        width: buttonWidth; height: buttonHeight

                        Text{
                            id: buttonLabel1
                            anchors.centerIn: parent
                            text: "Pause"
                        }
                        MouseArea{
                            id: buttonMouseArea1
                            anchors.fill: parent
                            onClicked:  mediaPlayer.pause()
                            hoverEnabled: true
                        }
                        color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor
                    }

                    Rectangle {
                        id: playButton
                        radius: 50
                        smooth: true
                        border{color: "green"; width: 3}
                        width: buttonWidth; height: buttonHeight

                        Text{
                            id: buttonLabel
                            anchors.centerIn: parent
                            text: "Play"
                        }
                        MouseArea{
                            id: buttonMouseArea
                            anchors.fill: parent    //stretch the area to the parent's dimension
                            onClicked:  mediaPlayer.play()
                            hoverEnabled: true
                        }
                        color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor
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

