import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import HuskarUI.Basic

Rectangle {
    id: volumeControl
    width: 180
    height: 38
    radius: 6
    border.width: 2
    border.color: '#e8e8e8'
    color: 'transparent'

    property real volume: volumeSlider.currentValue
    property bool muted: false

    function realVolume() {
        return muted ? 0 : volume
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

        onClicked: { muted = !muted; }
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

        HusCopyableText {
            id: volumeText
            anchors.left: parent.right
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(realVolume()) + '%'
            visible: width + volumeSlider.x < volumeControl.width
        }
    }
}
