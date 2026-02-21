import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import HuskarUI.Basic
import ACMusicPlayer

Rectangle {
    id: volumeControl
    width: 180
    height: 30
    radius: 6
    border.width: 2
    border.color: '#e8e8e8'
    color: 'transparent'

    property real log100: 4.60517018599

    function logarithmicVolumeToLinearVolume(volume)
    {
        var v = volume / 100.0;
        if (v > 0.99)
            return 100;
        else
            return Math.round((-Math.log(1 - v) / log100) * 100);
    }

    function realVolume() {
        return Player.muted ? 0 : Player.audioOutput.volume
    }

    ThemeImageButton {
        id: volumeIcon
        width: 24
        height: 24
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 8
        iconID: realVolume() === 0 ? 'volume-mute' : 'volume-up'

        onClicked: { Player.muted = !Player.muted; }
    }

    HusSlider {
        id: volumeSlider
        width: 80
        height: 24
        anchors.left: volumeIcon.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 6

        value: 100
        snapMode: HusSlider.SnapOnRelease

        onCurrentValueChanged: {
            Player.audioOutput.volume = logarithmicVolumeToLinearVolume(currentValue);
        }

        HusCopyableText {
            id: volumeText
            anchors.left: parent.right
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(parent.currentValue) + '%'
            visible: width + volumeSlider.x < volumeControl.width
        }
    }
}
