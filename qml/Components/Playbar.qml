import QtQuick
import QtQuick.Layouts
import HuskarUI.Basic
import ACMusicPlayer

Rectangle {
    id: playbar
    height: 70
    width: parent.width
    radius: 15
    border.width: 2
    border.color: '#e8e8e8'
    color: 'transparent'

    function optionImageID()
    {
        switch (Player.playingOption)
        {
        case ACMediaPlayer.Repeat:
            return 'repeat';
        case ACMediaPlayer.Sequence:
            return 'sequence';
        case ACMediaPlayer.Shuffle:
            return 'shuffle';
        }
    }

    PlaybarImageButton {
        id: optionButton
        anchors.left: parent.left
        anchors.leftMargin: 40
        iconIDActive: optionImageID()
        iconSize: 16

        onClicked: {
            switch (ACMediaPlayer.playingOption)
            {
            case ACMediaPlayer.Repeat:
                Player.playingOption = ACMediaPlayer.Sequence;
                break;
            case ACMediaPlayer.Sequence:
                Player.playingOption = ACMediaPlayer.Shuffle;
                break;
            case ACMediaPlayer.Shuffle:
                Player.playingOption = ACMediaPlayer.Repeat;
                break;
            }
        }
    }

    PlaybarImageButton {
        id: rewindButton
        anchors.left: optionButton.right
        anchors.leftMargin: 10
        iconIDActive: 'rewind'
        enabled: Player.hasMedia
        hasDisabledIcon: true

        onClicked: {
            // TODO:
        }
    }

    PlaybarImageButton {
        id: playButton
        anchors.left: rewindButton.right
        anchors.leftMargin: 10
        iconIDActive: Player.playing ? 'pause' : 'play'
        enabled: Player.hasMedia
        hasDisabledIcon: !Player.hasMedia

        onClicked: {
            if (Player.playing)
                Player.pause()
            else
                Player.play()
        }
    }

    PlaybarImageButton {
        id: fastForwardButton
        anchors.left: playButton.right
        anchors.leftMargin: 10
        iconIDActive: 'fast-forward'
        enabled: Player.hasMedia
        hasDisabledIcon: true

        onClicked: {
            // TODO:
        }
    }

    HusRectangle {
        id: playingMusicBar
        anchors.left: fastForwardButton.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 40
        anchors.topMargin: 8
        anchors.bottomMargin: 8
        height: parent.height
        width: parent.width - 480
        radius: 5
        border.color: '#e8e8e8'
        color: 'transparent'

        Rectangle {
            id: divider
            color: parent.border.color
            anchors.left: parent.left
            anchors.leftMargin: parent.height // for button width
            width: 1
            height: parent.height
            antialiasing: true
        }

        HusRectangle {
            id: musicCover
            anchors.left: parent.left
            anchors.right: divider.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            topLeftRadius: 5
            bottomLeftRadius: 5
            color: 'transparent'

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

            Image {
                id: musicCoverImage
                anchors.fill: parent
                anchors.margins: Player.coverUrl.isValid ? 0 : 15
                visible: !mouseArea.containsMouse
                source: Player.coverUrl.isValid ?
                            Player.coverUrl :
                            ('qrc:/img/song-disabled.png')
            }

            Rectangle {
                id: shrinkRect
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                topLeftRadius: 5
                bottomLeftRadius: 5
                anchors.fill: parent
                visible: mouseArea.containsMouse
                color: '#e8e8e8'
                ThemeImage {
                    id: shrinkImage
                    anchors.fill: parent
                    anchors.margins: 15
                    iconID: 'shrink'

                    MouseArea {
                        onClicked: {
                            // TODO: shrink the window
                        }
                    }
                }
            }
        }

        Rectangle {
            id: musicStatusBar
            anchors.left: divider.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            color: 'transparent'

            Item {
                id: musicStatusBarContent
                anchors.fill: parent

                ThemeImage {
                    id: defaultImage
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    visible: !Player.playing
                    iconID: 'artist' // TODO: For temp, no suit image found :(
                    width: parent.height - 20
                    height: parent.height - 20
                }

                Item {
                    id: contentWhenPlaying
                    anchors.fill: parent
                    visible: Player.playing

                    // TODO:
                    HusText {
                        text: 'PlaceHolder'
                    }
                }
            }
        }
    }

    ThemeImageButton {
        id: volumeIconInPlaybar
        width: 24
        height: 24
        anchors.left: playingMusicBar.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 40
        iconID: slider.realVolume() === 0 ? 'volume-mute' : 'volume-up'

        onClicked: { slider.visible = !slider.visible; }
    }

    VolumeSlider {
        id: slider
        anchors.left: volumeIconInPlaybar.left
        anchors.top: volumeIconInPlaybar.top
        anchors.bottom: volumeIconInPlaybar.bottom
        height: volumeIconInPlaybar.height
        visible: false
    }
}
