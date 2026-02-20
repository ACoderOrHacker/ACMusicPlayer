import QtQuick
import QtQuick.Layouts
import HuskarUI.Basic

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
        switch (ACMediaPlayer.playingOption)
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

        onClicked: {
            switch (ACMediaPlayer.playingOption)
            {
            case ACMediaPlayer.Repeat:
                ACMediaPlayer.playingOption = ACMediaPlayer.Sequence;
                break;
            case ACMediaPlayer.Sequence:
                ACMediaPlayer.playingOption = ACMediaPlayer.Shuffle;
                break;
            case ACMediaPlayer.Shuffle:
                ACMediaPlayer.playingOption = ACMediaPlayer.Repeat;
                break;
            }
        }
    }

    PlaybarImageButton {
        id: rewindButton
        anchors.left: optionButton.right
        anchors.leftMargin: 10
        iconIDActive: 'rewind'
        enabled: ACMediaPlayer.hasMedia
        hasDisabledIcon: true

        onClicked: {
            // TODO:
        }
    }

    PlaybarImageButton {
        id: playButton
        anchors.left: rewindButton.right
        anchors.leftMargin: 10
        iconIDActive: ACMediaPlayer.isPlaying ? 'pause' : 'play'
        enabled: ACMediaPlayer.hasMedia
        hasDisabledIcon: true

        onClicked: {
            console.log("hhh")
            if (ACMediaPlayer.isPlaying)
                ACMediaPlayer.pause()
            else
                ACMediaPlayer.play()
        }
    }

    PlaybarImageButton {
        id: fastForwardButton
        anchors.left: playButton.right
        anchors.leftMargin: 10
        iconIDActive: 'fast-forward'
        enabled: ACMediaPlayer.hasMedia
        hasDisabledIcon: true

        onClicked: {
            // TODO:
        }
    }
}
