// Copyright (c) 2018, The Xtendcash Project
// Copyright (c) 2014-2018, The Monero Project
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import XtendcashComponents.WalletManager 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.1
import "../components"
import "utils.js" as Utils

ColumnLayout {
    Layout.leftMargin: wizardLeftMargin
    Layout.rightMargin: wizardRightMargin

    id: root
    opacity: 0
    visible: false
    property alias titleText: titleText.text
    Behavior on opacity {
        NumberAnimation { duration: 100; easing.type: Easing.InQuad }
    }

    onOpacityChanged: visible = opacity !== 0


    function onPageOpened(settingsObject) {
        localNode.checked  = false;
        remoteNode.checked = true;
    }
    function onWizardRestarted(){
    }

    function onPageClosed(settingsObject) {
        appWindow.persistentSettings.useRemoteNode = remoteNode.checked
        appWindow.persistentSettings.remoteNodeAddress = remoteNodeEdit.getAddress();
        appWindow.persistentSettings.bootstrapNodeAddress = bootstrapNodeEdit.daemonAddrText ? bootstrapNodeEdit.getAddress() : "";
        return true
    }

    RowLayout {
        id: dotsRow
        Layout.alignment: Qt.AlignRight

        ListModel {
            id: dotsModel
            ListElement { dotColor: "#36B05B" }
            ListElement { dotColor: "#36B05B" }
            ListElement { dotColor: "#FFE00A" }
            ListElement { dotColor: "#DBDBDB" }
        }

        Repeater {
            model: dotsModel
            delegate: Rectangle {
                // Password page is last page when creating view only wallet
                // TODO: make this dynamic for all pages in wizard
                visible: (wizard.currentPath != "create_view_only_wallet" || index < 2)
                width: 12; height: 12
                radius: 6
                color: dotColor
            }
        }
    }

    ColumnLayout {
        id: headerColumn
        Layout.fillWidth: true
        Layout.bottomMargin: 14 * scaleRatio;

        Text {
            Layout.fillWidth: true
            id: titleText
            font.family: "Arial"
            font.pixelSize: 28 * scaleRatio
            wrapMode: Text.Wrap
            //renderType: Text.NativeRendering
            color: Style.defaultFontColor
            text: "Daemon Settings"
        }

        Text {
            Layout.topMargin: 30 * scaleRatio
            Layout.bottomMargin: 30 * scaleRatio
            font.family: "Arial"
            font.pixelSize: 18 * scaleRatio
            wrapMode: Text.Wrap
            //renderType: Text.NativeRendering
            color: Style.defaultFontColor
            textFormat: Text.RichText
//            horizontalAlignment: Text.AlignHCenter
            text: qsTr("To be able to communicate with the Xtendcash network your wallet needs to be connected \
                        <br> \
                        to a Xtendcash node. For best privacy it's recommended to run your own node. \
                        <br> \
                        <br> \
                        If you don't have the option to run your own node, there's an option to connect \
                        <br> \
                        to a remote node.")
                    + translationManager.emptyString
        }

        RadioButton {
            id: remoteNode
            text: qsTr("Connect to a remote node\n(Recommended, fast but less private)") + translationManager.emptyString
            Layout.topMargin: 20 * scaleRatio
            fontColor: Style.defaultFontColor
            fontSize: 16 * scaleRatio
            checked: appWindow.persistentSettings.useRemoteNode
            onClicked: {
                checked = true
                localNode.checked = false
            }
        }

        RadioButton {
            id: localNode
            text: qsTr("Start a node automatically in background or use an already running local node\n(Downloads blockchain, slow but private)") + translationManager.emptyString
            fontColor: Style.defaultFontColor
            fontSize: 16 * scaleRatio
            checked: !appWindow.persistentSettings.useRemoteNode && !isAndroid && !isIOS
            visible: !isAndroid && !isIOS
            onClicked: {
                checked = true;
                remoteNode.checked = false;
            }
        }

    }


    ColumnLayout {
        visible: localNode.checked
        id: blockchainFolderRow

        Label {
            Layout.fillWidth: true
            Layout.topMargin: 20 * scaleRatio
            fontSize: 16 * scaleRatio
            fontColor: Style.defaultFontColor
            text: qsTr("Blockchain Location") + translationManager.emptyString
        }

        LineEdit {
            id: blockchainFolder
            Layout.minimumWidth: 300 * scaleRatio
            Layout.maximumWidth: 620 * scaleRatio
            Layout.fillWidth: true
            text: persistentSettings.blockchainDataDir
            placeholderFontFamily: "Arial"
            placeholderColor: Style.legacy_placeholderFontColor
            placeholderText: qsTr("(Optional)") + translationManager.emptyString

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mouse.accepted = false
                    if(persistentSettings.blockchainDataDir != "")
                        blockchainFileDialog.folder = "file://" + persistentSettings.blockchainDataDir
                    blockchainFileDialog.open()
                    blockchainFolder.focus = true
                }
            }
        }

        RemoteNodeEdit {
            Layout.minimumWidth: 300 * scaleRatio
            Layout.maximumWidth: 620 * scaleRatio
            opacity: localNode.checked
            id: bootstrapNodeEdit

            lineEditBackgroundColor: "transparent"
            lineEditFontColor: "white"
            lineEditFontBold: false

            placeholderFontFamily: "Arial"
            placeholderColor: Style.legacy_placeholderFontColor

            daemonAddrLabelText: qsTr("Bootstrap Address")
            daemonPortLabelText: qsTr("Bootstrap Port")
            daemonAddrText: persistentSettings.bootstrapNodeAddress.split(":")[0].trim()
            daemonPortText: {
                var node_split = persistentSettings.bootstrapNodeAddress.split(":");
                if(node_split.length == 2){
                    (node_split[1].trim() == "") ? "" : node_split[1];
                } else {
                    return ""
                }
            }
        }
    }

    ColumnLayout {
        visible: remoteNode.checked
        spacing: 10
        Layout.bottomMargin: 20

        WarningBox {
            Layout.bottomMargin: 6 * scaleRatio
            Layout.maximumWidth: 620 * scaleRatio
            text: qsTr("To find other remote nodes, type 'Xtendcash remote node' into your favorite search engine. Please ensure the node is run by a trusted third-party.") + translationManager.emptyString
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 20 * scaleRatio
            Layout.topMargin: 8 * scaleRatio
            color: Style.defaultFontColor
            font.family: Style.fontRegular.name
            font.pixelSize: 16 * scaleRatio
            text: qsTr("Default Remote Node(s)") + translationManager.emptyString
        }

        Rectangle {
            Layout.preferredHeight: 1 * scaleRatio
            color: Style.dividerColor
            opacity: Style.dividerOpacity
        }

        ListView {
            height: 110 * scaleRatio
            Layout.fillWidth: true
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: getRemoteNodeList()

            delegate: Rectangle {
                color: "transparent"
                height: 34 * scaleRatio
                Layout.fillWidth: true

                StandardButton {
                    id: defaultNodeButton
                    anchors.left: parent.left
                    small: true
                    text: qsTr("Load Preset") + translationManager.emptyString
                    width: 120 * scaleRatio
                    onClicked: {

                        var node_split = modelData.split(":");
                        if(node_split.length == 2){
                            (node_split[1].trim() == "") ? "" : node_split[1];
                        } else {
                            return;
                        }

                        remoteNodeEdit.daemonAddrText = node_split[0];
                        remoteNodeEdit.daemonPortText = node_split[1];
                    }
                }

                Text {
                    Layout.preferredHeight: 16 * scaleRatio
                    anchors.left: defaultNodeButton.right
                    anchors.leftMargin: 8 * scaleRatio
                    anchors.verticalCenter: defaultNodeButton.verticalCenter
                    color: Style.defaultFontColor
                    font.family: Style.fontRegular.name
                    font.pixelSize: 14 * scaleRatio
                    text: "Address: " + modelData
                }
            }
        }

        RemoteNodeEdit {
            Layout.minimumWidth: 300 * scaleRatio
            Layout.maximumWidth: 620 * scaleRatio
            Layout.fillWidth: true
            id: remoteNodeEdit
            property var rna: persistentSettings.remoteNodeAddress

            lineEditBackgroundColor: "transparent"
            lineEditFontColor: "white"
            lineEditFontBold: false
            labelFontSize: 14 * scaleRatio
            placeholderFontSize: 15 * scaleRatio

            daemonAddrLabelText: qsTr("Address")
            daemonPortLabelText: qsTr("Port")
            daemonAddrText: rna.search(":") != -1 ? rna.split(":")[0].trim() : ""
            daemonPortText: rna.search(":") != -1 ? (rna.split(":")[1].trim() == "") ? "" : persistentSettings.remoteNodeAddress.split(":")[1] : ""
        }

    }

    Component.onCompleted: {
        parent.wizardRestarted.connect(onWizardRestarted)
    }
}
