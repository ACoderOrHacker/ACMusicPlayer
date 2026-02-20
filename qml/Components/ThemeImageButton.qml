import QtQuick
import HuskarUI.Basic

HusIconButton {
    property string iconID
    iconSource: 'qrc:/img/' + iconID + (HusTheme.isDark ? '-dark' : '-light') + '.png'
    type: HusIconButton.Type_Text
}
