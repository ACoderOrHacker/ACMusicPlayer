import QtQuick
import HuskarUI.Basic

ThemeImageButton {
    id: playbarImageButton

    property string iconIDActive: ''
    property bool hasDisabledIcon: false
    property int decreaseSize: 40
    property int defaultIconSize: 16

    function disabledIconID(id)
    {
        return id + '-disabled';
    }

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.topMargin: decreaseSize / 2
    anchors.bottomMargin: decreaseSize / 2
    width: parent.height - decreaseSize
    height: parent.height - decreaseSize
    iconSize: defaultIconSize
    iconSource:
        'qrc:/img/' + ((hasDisabledIcon && (!enabled)) ? (iconIDActive + '-disabled') :
            (iconIDActive + (HusTheme.isDark ? '-dark' : '-light'))) + '.png'
    themeSource: {
        var theme = HusTheme.HusButton;
        theme.colorBgDisabled = 'transparent'
        return theme;
    }
}
