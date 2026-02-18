pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import HuskarUI.Basic

import './Home'

HusWindow {
    id: mplayerWindow
    width: 1400
    height: 800
    opacity: 0
    minimumWidth: 800
    minimumHeight: 600
    title: qsTr('ACMusic Player')
    followThemeSwitch: true
    captionBar.visible: Qt.platform.os === 'windows' || Qt.platform.os === 'linux' || Qt.platform.os === 'osx'
    captionBar.height: captionBar.visible ? 30 : 0
    captionBar.color: HusTheme.Primary.colorFillTertiary
    captionBar.showThemeButton: true
    captionBar.showTopButton: true
    captionBar.showWinIcon: Qt.platform.os !== 'osx'
    captionBar.winIconDelegate: Item {
        Image {
            width: 16
            height: 16
            anchors.centerIn: parent
            source: 'qrc:/img/favicon.png'
        }
    }
    captionBar.themeCallback: () => {
        themeSwitchLoader.active = true;
    }
    captionBar.topCallback: (checked) => {
        HusApi.setWindowStaysOnTopHint(mplayerWindow, checked);
    }
    captionBar.winTitleDelegate: RowLayout {
        layoutDirection: captionBar.mirrored ? Qt.RightToLeft : Qt.LeftToRight
        spacing: 0

        Connections {
            target: captionBar
            function onWindowAgentChanged() {
                captionBar.addInteractionItem(goBackButton);
                captionBar.addInteractionItem(goForwardButton);
                captionBar.addInteractionItem(historyButton);
            }
        }

        HusText {
            text: captionBar.winTitle
            color: captionBar.winTitleColor
            font: captionBar.winTitleFont
        }

        HusCaptionButton {
            id: goBackButton
            Layout.leftMargin: 10
            Layout.fillHeight: true
            noDisabledState: true
            enabled: galleryRouter.canGoBack
            hoverCursorShape: Qt.PointingHandCursor
            iconSource: HusIcon.ArrowLeftOutlined
            iconSize: 14
            colorIcon: enabled ? themeSource.colorIcon :
                                 themeSource.colorIconDisabled
            colorBg: {
                if (enabled) {
                    return active ? themeSource.colorBgActive :
                                    hovered ? themeSource.colorBgHover : 'transparent';
                } else {
                    return 'transparent';
                }
            }
            contentDescription: qsTr('后退')
            onClicked: galleryRouter.goBack();

            HusToolTip {
                visible: parent.hovered
                showArrow: true
                position: HusToolTip.Position_Bottom
                text: parent.contentDescription
            }
        }

        HusCaptionButton {
            id: goForwardButton
            Layout.fillHeight: true
            noDisabledState: true
            enabled: galleryRouter.canGoForward
            hoverCursorShape: Qt.PointingHandCursor
            iconSource: HusIcon.ArrowRightOutlined
            iconSize: 14
            colorIcon: enabled ? themeSource.colorIcon :
                                 themeSource.colorIconDisabled
            colorBg: {
                if (enabled) {
                    return active ? themeSource.colorBgActive :
                                    hovered ? themeSource.colorBgHover : 'transparent';
                } else {
                    return 'transparent';
                }
            }
            contentDescription: qsTr('前进')
            onClicked: galleryRouter.goForward();

            HusToolTip {
                visible: parent.hovered
                showArrow: true
                position: HusToolTip.Position_Bottom
                text: parent.contentDescription
            }
        }

        HusCaptionButton {
            id: historyButton
            Layout.fillHeight: true
            visible: true
            noDisabledState: true
            hoverCursorShape: Qt.PointingHandCursor
            iconSource: HusIcon.HistoryOutlined
            iconSize: 14
            contentDescription: qsTr('History')
            onClicked: historyPopup.open();

            HusToolTip {
                visible: parent.hovered
                showArrow: true
                position: HusToolTip.Position_Bottom
                text: parent.contentDescription
            }

            HusPopup {
                id: historyPopup
                x: (parent.width - width) * 0.5
                y: parent.height
                padding: 5
                contentItem: ListView {
                    implicitWidth: 180
                    implicitHeight: Math.min(contentHeight, 300)
                    clip: true
                    model: galleryRouter.history
                    delegate: HusButton {
                        width: ListView.view.width
                        effectEnabled: false
                        text: urlData.label
                        colorBorder: 'transparent'
                        radiusBg.all: 0
                        onClicked: galleryRouter.gotoUrl(modelData.location);
                        required property var modelData
                        property var urlData: galleryRouter.urlDataMap.get(modelData.location)
                    }
                    ScrollBar.vertical: HusScrollBar { }
                }
            }
        }
    }
    captionBar.winPresetButtonsDelegate: RowLayout {
        layoutDirection: captionBar.mirrored ? Qt.RightToLeft : Qt.LeftToRight
        spacing: 0

        Connections {
            target: captionBar
            function onWindowAgentChanged() {
                captionBar.addInteractionItem(themeButton);
                captionBar.addInteractionItem(settingsButton);
                captionBar.addInteractionItem(topButton);
            }
        }

        HusCaptionButton {
            id: themeButton
            Layout.fillHeight: true
            noDisabledState: true
            iconSource: HusTheme.isDark ? HusIcon.MoonOutlined : HusIcon.SunOutlined
            iconSize: 14
            contentDescription: qsTr('Theme Switch')
            onClicked: captionBar.themeCallback();
        }

        HusCaptionButton {
            id: settingsButton
            Layout.fillHeight: true
            noDisabledState: true
            iconSource: HusIcon.SettingOutlined
            contentDescription: qsTr('Settings')
            onClicked: {
                if (!settingsLoader.active)
                settingsLoader.active = true;
                settingsLoader.visible = !settingsLoader.visible;
            }

            HusToolTip {
                visible: parent.hovered
                showArrow: true
                position: HusToolTip.Position_Bottom
                text: parent.contentDescription
            }
        }

        HusCaptionButton {
            id: topButton
            Layout.fillHeight: true
            noDisabledState: true
            iconSource: HusIcon.PushpinOutlined
            iconSize: 14
            checkable: true
            checked: captionBar.topButtonChecked
            contentDescription: qsTr('Top')
            onClicked: captionBar.topCallback(checked);
        }
    }

    HusRouter {
        id: galleryRouter
        property var urlDataMap: new Map
        function gotoUrl(url) {
            if (urlDataMap.has(url)) {
                const data = urlDataMap.get((url));
                galleryMenu.gotoMenu(data.key);
            }
        }
        onCurrentUrlChanged: gotoUrl(currentUrl);
    }

    Loader {
        id: themeSwitchLoader
        z: 65536
        active: false
        anchors.fill: mplayerWindow.contentItem
        sourceComponent: ThemeSwitchItem {
            opacity: mplayerWindow.specialEffect == HusWindow.None ? 1.0 : mplayerBackground.opacity
            target: mplayerWindow.contentItem
            isDark: HusTheme.isDark
            onSwitchStarted: {
                themeSwitchLoader.changeDark();
            }
            onAnimationFinished: {
                if (mplayerWindow.specialEffect === HusWindow.None)
                mplayerWindow.color = HusTheme.Primary.colorBgBase;
                themeSwitchLoader.active = false;
            }
            Component.onCompleted: {
                colorBg = HusTheme.isDark ? '#f5f5f5' : '#181818';
                const distance = function(x1, y1, x2, y2) {
                    return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
                }
                const startX = content.width - 170;
                const startY = 0;
                const radius = Math.max(distance(startX, startY, 0, 0),
                                        distance(startX, startY, content.width, 0),
                                        distance(startX, startY, 0, content.height),
                                        distance(startX, startY, content.width, content.height));
                start(width, height, Qt.point(startX, startY), radius);
            }
        }

        function changeDark() {
            HusTheme.darkMode = HusTheme.isDark ? HusTheme.Light : HusTheme.Dark;
        }

        Connections {
            target: HusTheme
            function onIsDarkChanged() {
                if (HusTheme.darkMode === HusTheme.System) {
                    mplayerWindow.setWindowMode(HusTheme.isDark);
                }
            }
        }
    }

    Loader {
        id: settingsLoader
        z: 65536
        active: false
        visible: false
        anchors.fill: mplayerWindow.contentItem
        sourceComponent: SettingsPage { visible: settingsLoader.visible }
    }

    Component.onCompleted: {
        if (Qt.platform.os === 'windows') {
            if (setSpecialEffect(HusWindow.Win_MicaAlt)) return;
            if (setSpecialEffect(HusWindow.Win_Mica)) return;
            if (setSpecialEffect(HusWindow.Win_AcrylicMaterial)) return;
            if (setSpecialEffect(HusWindow.Win_DwmBlur)) return;
        } else if (Qt.platform.os === 'osx') {
            if (setSpecialEffect(HusWindow.Mac_BlurEffect)) return;
        }
    }

    Behavior on opacity { NumberAnimation { } }

    Timer {
        running: true
        interval: 200
        onTriggered: {
            mplayerWindow.opacity = 1;
        }
    }

    Rectangle {
        id: mplayerBackground
        anchors.fill: content
        color: HusTheme.isDark ? '#181818' : '#f5f5f5'
        opacity: 0.2
    }

    Item {
        id: content
        anchors.top: mplayerWindow.captionBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            id: sidebar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            HusIconButton {
                id: navModeSwitchBtn
                anchors.top: parent.top
                anchors.left: parent.left
                iconSource: galleryMenu.compactMode === HusMenu.Mode_Relaxed ? HusIcon.MenuOutlined : HusIcon.MenuFoldOutlined
                iconSize: galleryMenu.defaultMenuIconSize
                checkable: false
                colorText: HusTheme.Primary.colorTextBase
                type: HusButton.Type_Text
                onClicked: {
                    galleryMenu.compactMode = galleryMenu.compactMode === HusMenu.Mode_Relaxed ? HusMenu.Mode_Compact : HusMenu.Mode_Relaxed;
                }
                SequentialAnimation on rotation {
                    NumberAnimation { from: 0; to: 180; duration: 180; easing.type: Easing.InOutQuad }
                }
                Behavior on iconSource { NumberAnimation { duration: 120 } }
            }

            HusAutoComplete {
                id: searchComponent
                property bool expanded: false
                z: 10
                clip: true
                width: (galleryMenu.compactMode === HusMenu.Mode_Relaxed || expanded) ? (galleryMenu.defaultMenuWidth - 20) : 0
                anchors.top: navModeSwitchBtn.bottom
                anchors.left: galleryMenu.compactMode === HusMenu.Mode_Relaxed ? galleryMenu.left : galleryMenu.right
                anchors.margins: 10
                anchors.topMargin: 5
                topPadding: 6
                bottomPadding: 6
                rightPadding: 50
                showToolTip: true
                placeholderText: qsTr('Search')
                iconSource: HusIcon.SearchOutlined
                colorBg: !(galleryMenu.compactMode === HusMenu.Mode_Relaxed) ? HusTheme.HusInput.colorBg : 'transparent'
                //TODO: options for searching
                filterOption: (input, option) => option.label.toUpperCase().indexOf(input.toUpperCase()) !== -1
                onSelect: option => galleryMenu.gotoMenu(option.key)
                labelDelegate: HusText {
                    height: implicitHeight + 4
                    text: parent.textData
                    color: HusTheme.HusAutoComplete.colorItemText
                    font {
                        family: HusTheme.HusAutoComplete.fontFamily
                        pixelSize: HusTheme.HusAutoComplete.fontSize
                        weight: parent.highlighted ? Font.DemiBold : Font.Normal
                    }
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter

                    property var model: parent.modelData
                    property string tagState: model.state ?? ''

                    HusTag {
                        id: __tag
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: parent.tagState
                        presetColor: parent.tagState === 'New' ? 'red' : 'green'
                        visible: parent.tagState !== ''
                    }
                }

                Keys.onEscapePressed: {
                    if (expanded) {
                        expanded = false;
                    } else {
                        closePopup();
                    }
                }

                Behavior on width {
                    enabled: !(galleryMenu.compactMode === HusMenu.Mode_Relaxed) &&
                             galleryMenu.width === galleryMenu.compactWidth
                    NumberAnimation { duration: HusTheme.Primary.durationFast }
                }
            }

            HusIconButton {
                id: searchCollapse
                visible: !(galleryMenu.compactMode === HusMenu.Mode_Relaxed)
                anchors.top: navModeSwitchBtn.bottom
                anchors.left: galleryMenu.left
                anchors.right: galleryMenu.right
                anchors.margins: 10
                type: HusButton.Type_Text
                colorText: HusTheme.Primary.colorTextBase
                iconSource: HusIcon.SearchOutlined
                iconSize: searchComponent.iconSize
                onClicked: {
                    searchComponent.expanded = !searchComponent.expanded;
                    galleryMenu.compactMode = HusMenu.Mode_Relaxed;
                    if (searchComponent.expanded) {
                        searchComponent.forceActiveFocus();
                    }
                }
                onVisibleChanged: {
                    if (visible) {
                        searchComponent.closePopup();
                        searchComponent.expanded = false;
                    }
                }
            }

            HusMenu {
                id: galleryMenu
                anchors.left: parent.left
                anchors.top: searchComponent.bottom
                showEdge: true
                showToolTip: true
                defaultMenuWidth: 300
                defaultSelectedKeys: ['HomePage']
                initModel: [
                    {
                        key: 'HomePage',
                        label: qsTr('Home'),
                        iconSource: HusIcon.HomeOutlined,
                        source: './Home/HomePage.qml'
                    },
                    {
                        key: 'Music',
                        label: qsTr('Listen'),
                        iconSource: HusIcon.AudioFilled,
                        source: './Home/MusicHome.qml'
                    }
                ]

                menuLabelDelegate: HusText {
                    text: menuButton.text
                    font: menuButton.font
                    color: menuButton.colorText
                    elide: Text.ElideRight

                    property var model: parent.model
                    property var menuButton: parent.menuButton
                    property string tagState: model.state ?? ''

                    HusTag {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: parent.tagState
                        presetColor: parent.tagState === 'New' ? 'red' : 'green'
                        visible: parent.tagState !== ''
                    }
                }
                menuBgDelegate: Rectangle {
                    radius: menuButton.radiusBg.all
                    color: menuButton.colorBg
                    border.color: menuButton.colorBorder
                    border.width: 1

                    property var model: parent.model
                    property var menuButton: parent.menuButton
                    property string badgeState: model.badgeState ?? ''

                    Behavior on color { enabled: galleryMenu.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationMid } }
                    Behavior on border.color { enabled: galleryMenu.animationEnabled; ColorAnimation { duration: HusTheme.Primary.durationMid } }

                    HusBadge {
                        anchors.left: undefined
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: undefined
                        anchors.margins: 1
                        dot: true
                        presetColor: parent.badgeState == 'New' ? 'red' : 'green'
                        visible: parent.badgeState !== ''
                    }
                }
                onClickMenu: function(deep, key, keyPath, data) {
                    if (data) {
                        if (data.hasOwnProperty('menuChildren')) {
                            setDataProperty(key, 'badgeState', '');
                        } else {
                            galleryRouter.urlDataMap.set(Qt.url(data.source), data);
                            galleryRouter.push(data.source);
                            console.debug('onClickMenu', deep, key, keyPath, JSON.stringify(data));
                        }
                    }
                }
            }
        }

        Item {
            id: container
            visible: true
            anchors.left: sidebar.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 5
            clip: true

            property string pageSource: (galleryRouter.urlDataMap.get(galleryRouter.currentUrl) || {}).source
            Loader {
                anchors.fill: parent
                source: container.pageSource
            }
        }
    }
}
