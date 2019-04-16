import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import "." as LokiComponents

Rectangle {
    id: root
    property alias text: content.text
    property int fontSize: 15 * scaleRatio

    Layout.fillWidth: true
    Layout.preferredHeight: warningLayout.height

    color: "#09FFFFFF"
    radius: 4
    border.color: LokiComponents.Style.inputBorderColorInActive
    border.width: 1
    
    signal linkActivated;
    
    RowLayout {
        id: warningLayout
        spacing: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Image {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: 33
            Layout.preferredWidth: 33
            Layout.rightMargin: 14
            Layout.leftMargin: 14
            Layout.topMargin: 12
            Layout.bottomMargin: 12
            source: "../images/warning.png"
        }

        TextArea {
            id: content
            Layout.fillWidth: true
            color: LokiComponents.Style.defaultFontColor
            font.family: LokiComponents.Style.fontRegular.name
            font.pixelSize: root.fontSize
            horizontalAlignment: TextInput.AlignLeft
            selectByMouse: false
            textFormat: Text.RichText
            wrapMode: Text.WordWrap
            textMargin: 0
            leftPadding: 0
            topPadding: 6
            readOnly: true
            onLinkActivated: root.linkActivated();

            // @TODO: Legacy. Remove after Qt 5.8.
            // https://stackoverflow.com/questions/41990013
            MouseArea {
                anchors.fill: parent
                enabled: false
            }
        }
    }
}
