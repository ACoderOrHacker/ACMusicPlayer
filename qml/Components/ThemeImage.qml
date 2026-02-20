import QtQuick
import HuskarUI.Basic

Image {
    property string iconID
    source: 'qrc:/img/' + iconID + (HusTheme.isDark ? '-dark' : '-light') + '.png'
}
