import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.Basic
import HuskarUI.Basic

HusWindow {
    id: root
    width: 400
    height: 500
    minimumWidth: 400
    minimumHeight: 500
    captionBar.showMinimizeButton: false
    captionBar.showMaximizeButton: false
    captionBar.winTitle: qsTr('About')
    captionBar.winIconDelegate: Item {
        Image {
            width: 16
            height: 16
            anchors.centerIn: parent
            source: 'qrc:/img/favicon.png'
        }
    }
    captionBar.closeCallback: () => aboutLoader.visible = false;
    Item {
        anchors.fill: parent

        MultiEffect {
            anchors.fill: backRect
            source: backRect
            shadowColor: HusTheme.Primary.colorTextBase
            shadowEnabled: true
        }

        Rectangle {
            id: backRect
            anchors.fill: parent
            radius: 6
            color: HusTheme.Primary.colorBgBase
            border.color: HusThemeFunctions.alpha(HusTheme.Primary.colorTextBase, 0.2)
        }

        Item {
            anchors.fill: parent
        }


    }
}
