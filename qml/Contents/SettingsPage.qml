import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.Basic
import HuskarUI.Basic

HusWindow {
    id: root
    width: 550
    height: 600
    minimumWidth: 550
    minimumHeight: 600
    captionBar.showMinimizeButton: false
    captionBar.showMaximizeButton: false
    captionBar.winTitle: qsTr('Settings')
    captionBar.winIconDelegate: Item {
        Image {
            width: 16
            height: 16
            anchors.centerIn: parent
            source: 'qrc:/img/app.png'
        }
    }
    captionBar.closeCallback: () => settingsLoader.visible = false;

    component SettingsItem: Item {
        id: settingsItem
        width: parent.width
        height: column.height

        property string title
        property Component itemDelegate: Item { }

        Column {
            id: column
            width: parent.width
            spacing: 10

            HusText {
                text: settingsItem.title
            }

            Rectangle {
                width: parent.width
                height: itemLoader.height + 40
                radius: 6
                color: HusThemeFunctions.alpha(HusTheme.Primary.colorBgBase, 0.6)
                border.color: HusTheme.Primary.colorFillPrimary

                Loader {
                    id: itemLoader
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 20
                    anchors.verticalCenter: parent.verticalCenter
                    sourceComponent: settingsItem.itemDelegate
                }
            }
        }
    }

    Flickable {
        anchors.fill: parent
        anchors.topMargin: root.captionBar.height
        anchors.bottomMargin: 20
        clip: true
        contentHeight: contentColumn.height
        ScrollBar.vertical: HusScrollBar {
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Column {
            id: contentColumn
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            spacing: 20

            SettingsItem {
                title: qsTr('Apply Theme')
                itemDelegate: Column {
                    spacing: 10

                    ButtonGroup { id: themeGroup }

                    Repeater {
                        model: [
                            { 'label': qsTr('Light'), 'value': HusTheme.Light },
                            { 'label': qsTr('Dark'), 'value': HusTheme.Dark },
                            { 'label': qsTr('Follow System'), 'value': HusTheme.System }
                        ]
                        delegate: HusRadio {
                            id: darkModeRadio
                            text: modelData.label
                            ButtonGroup.group: themeGroup
                            onClicked: {
                                HusTheme.darkMode = modelData.value;
                            }
                            Component.onCompleted: {
                                checked = HusTheme.darkMode === modelData.value;
                            }

                            Connections {
                                target: HusTheme
                                function onDarkModeChanged() {
                                    darkModeRadio.checked = HusTheme.darkMode === modelData.value;
                                }
                            }
                        }
                    }
                }
            }

            SettingsItem {
                title: qsTr('About')
                itemDelegate: Column {
                    width: parent.width
                    height: 200
                    anchors.top: parent.top
                    anchors.topMargin: captionBar.height
                    spacing: 10

                    Item {
                        width: 60
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            width: parent.width
                            height: width
                            anchors.centerIn: parent
                            source: 'qrc:/img/app.png'
                        }
                    }

                    HusText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font {
                            family: HusTheme.Primary.fontPrimaryFamily
                            pixelSize: HusTheme.Primary.fontPrimarySizeHeading3
                            bold: true
                        }
                        text: qsTr('ACMusic Player')
                    }

                    HusCopyableText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr('HuskarUI Version: ') + HusApp.libVersion()
                    }

                    HusCopyableText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr('Author: ACoderOrHacker')
                    }
                }
            }
        }
    }
}
