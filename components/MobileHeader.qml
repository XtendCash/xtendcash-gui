import QtQuick 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

import LokiComponents.Wallet 1.0
import "../components" as LokiComponents

// BasicPanel header
Rectangle {
    id: header
    anchors.leftMargin: 1
    anchors.rightMargin: 1
    Layout.fillWidth: true
    Layout.preferredHeight: 64 * scaleRatio
    color: "#FFFFFF"

    Image {
        id: logo
        visible: appWindow.width > 460 * scaleRatio
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
        anchors.left: parent.left
        anchors.leftMargin: 50 * scaleRatio
        source: "../images/LokiLogo2.png"
    }

    Image {
        id: icon
        visible: !logo.visible
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 40 * scaleRatio
        source: "../images/LokiIcon.png"
    }

    Grid {
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10 * scaleRatio
        width: 256 * scaleRatio
        columns: 3

        Text {
            id: balanceLabel
            width: 116 * scaleRatio
            height: 20 * scaleRatio
            font.family: "Arial"
            font.pixelSize: 12 * scaleRatio
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#535353"
            text: leftPanel.balanceLabelText + ":"
        }

        Text {
            id: balanceText
            width: 110 * scaleRatio
            height: 20 * scaleRatio
            font.family: "Arial"
            font.pixelSize: 18 * scaleRatio
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#000000"
            text: leftPanel.balanceText
        }

        Item {
            height: 20 * scaleRatio
            width: 20 * scaleRatio

            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                source: "../images/lockIcon.png"
            }
        }

        Text {
            width: 116 * scaleRatio
            height: 20 * scaleRatio
            font.family: "Arial"
            font.pixelSize: 12 * scaleRatio
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#535353"
            text: qsTr("Unlocked Balance:")
        }

        Text {
            id: availableBalanceText
            width: 110 * scaleRatio
            height: 20 * scaleRatio
            font.family: "Arial"
            font.pixelSize: 14 * scaleRatio
            font.letterSpacing: -1
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: "#000000"
            text: leftPanel.unlockedBalanceText
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: "#DBDBDB"
    }
}
