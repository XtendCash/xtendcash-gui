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

import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import "../../components" as LokiComponents

Rectangle{
    color: "transparent"
    height: 1400
    Layout.fillWidth: true

    /* main layout */
    ColumnLayout {
        id: root
        anchors.margins: (isMobile)? 17 : 20
        anchors.topMargin: 0

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        spacing: 0 * scaleRatio
        property int labelWidth: 120
        property int editWidth: 400
        property int buttonWidth: 110

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            color: "transparent"

            Rectangle {
                id: localNodeDivider
                Layout.fillWidth: true
                anchors.topMargin: 0 * scaleRatio
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: LokiComponents.Style.dividerColor
                opacity: LokiComponents.Style.dividerOpacity
            }

            Rectangle {
                visible: !persistentSettings.useRemoteNode
                Layout.fillHeight: true
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "white"
                width: 2
            }

            Rectangle {
                width: parent.width
                height: localNodeHeader.height + localNodeArea.contentHeight
                color: "transparent";
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: localNodeIcon
                    color: "transparent"
                    height: 32
                    width: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 16 * scaleRatio
                    anchors.verticalCenter: parent.verticalCenter

                    Image{
                        height: 27
                        width: 27
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../../images/settings_local.png"
                    }
                }

                Text {
                    id: localNodeHeader
                    anchors.left: localNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    anchors.top: parent.top
                    color: "white"
                    font.bold: true
                    font.family: LokiComponents.Style.fontRegular.name
                    font.pixelSize: 16 * scaleRatio
                    text: qsTr("Local Node") + translationManager.emptyString
                }

                TextArea {
                    id: localNodeArea
                    anchors.top: localNodeHeader.bottom
                    anchors.topMargin: 4 * scaleRatio
                    anchors.left: localNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    color: LokiComponents.Style.dimmedFontColor
                    font.family: LokiComponents.Style.fontRegular.name
                    font.pixelSize: 15 * scaleRatio
                    horizontalAlignment: TextInput.AlignLeft
                    selectByMouse: false
                    wrapMode: Text.WordWrap;
                    textMargin: 0
                    leftPadding: 0
                    topPadding: 0
                    text: qsTr("The blockchain is downloaded to your computer. Provides higher security and requires more local storage.") + translationManager.emptyString
                    width: parent.width - (localNodeIcon.width + localNodeIcon.anchors.leftMargin + anchors.leftMargin)

                    // @TODO: Legacy. Remove after Qt 5.8.
                    // https://stackoverflow.com/questions/41990013
                    MouseArea {
                        anchors.fill: parent
                        enabled: false
                    }
                }   
            }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    persistentSettings.useRemoteNode = false;
                    appWindow.disconnectRemoteNode();
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            color: "transparent"

            Rectangle {
                id: remoteNodeDivider
                Layout.fillWidth: true
                anchors.topMargin: 0 * scaleRatio
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: LokiComponents.Style.dividerColor
                opacity: LokiComponents.Style.dividerOpacity
            }

            Rectangle {
                visible: persistentSettings.useRemoteNode
                Layout.fillHeight: true
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "white"
                width: 2
            }

            Rectangle {
                width: parent.width
                height: remoteNodeHeader.height + remoteNodeArea.contentHeight
                color: "transparent";
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: remoteNodeIcon
                    color: "transparent"
                    height: 32
                    width: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 16 * scaleRatio
                    anchors.verticalCenter: parent.verticalCenter

                    Image{
                        height: 27
                        width: 22
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../../images/settings_remote.png"
                    }
                }

                Text {
                    id: remoteNodeHeader
                    anchors.left: remoteNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    anchors.top: parent.top
                    color: "white"
                    font.bold: true
                    font.family: LokiComponents.Style.fontRegular.name
                    font.pixelSize: 16 * scaleRatio
                    text: qsTr("Remote Node") + translationManager.emptyString
                }

                TextArea {
                    id: remoteNodeArea
                    anchors.top: remoteNodeHeader.bottom
                    anchors.topMargin: 4 * scaleRatio
                    anchors.left: remoteNodeIcon.right
                    anchors.leftMargin: 14 * scaleRatio
                    color: LokiComponents.Style.dimmedFontColor
                    font.family: LokiComponents.Style.fontRegular.name
                    font.pixelSize: 15 * scaleRatio
                    activeFocusOnPress: false
                    horizontalAlignment: TextInput.AlignLeft
                    selectByMouse: false
                    wrapMode: Text.WordWrap;
                    textMargin: 0
                    leftPadding: 0
                    topPadding: 0
                    text: qsTr("Uses a third-party server to connect to the Loki network. Less secure, but easier on your computer.") + translationManager.emptyString
                    width: parent.width - (remoteNodeIcon.width + remoteNodeIcon.anchors.leftMargin + anchors.leftMargin)

                    // @TODO: Legacy. Remove after Qt 5.8.
                    // https://stackoverflow.com/questions/41990013
                    MouseArea {
                        anchors.fill: parent
                        enabled: false
                    }
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        persistentSettings.useRemoteNode = true;
                        appWindow.connectRemoteNode();
                    }
                }
            }

            Rectangle {
                id: localNodeBottomDivider
                Layout.fillWidth: true
                anchors.topMargin: 0 * scaleRatio
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: LokiComponents.Style.dividerColor
                opacity: LokiComponents.Style.dividerOpacity
            }
        }

        ColumnLayout {
            id: defaultRemoteNodes
            anchors.margins: 0
            Layout.fillWidth: true
            Layout.topMargin: 20
            spacing: 5 * scaleRatio
            visible: !isMobile && persistentSettings.useRemoteNode

            LokiComponents.WarningBox {
                Layout.topMargin: 26 * scaleRatio
                Layout.bottomMargin: 6 * scaleRatio
                text: qsTr("To find other remote nodes, type 'Loki remote node' into your favorite search engine. Please ensure the node is run by a trusted third-party.") + translationManager.emptyString
            }

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 20 * scaleRatio
                Layout.topMargin: 8 * scaleRatio
                color: LokiComponents.Style.defaultFontColor
                font.family: LokiComponents.Style.fontRegular.name
                font.pixelSize: 16 * scaleRatio
                text: qsTr("Default Remote Node(s)") + translationManager.emptyString
            }

            Rectangle {
                Layout.preferredHeight: 1 * scaleRatio
                Layout.fillWidth: true
                color: LokiComponents.Style.dividerColor
                opacity: LokiComponents.Style.dividerOpacity
            }

            Text {
                visible: (getRemoteNodeList().length == 0)
                Layout.fillWidth: true
                color: LokiComponents.Style.defaultFontColor
                font.family: LokiComponents.Style.fontRegular.name
                font.pixelSize: 16 * scaleRatio
                text: qsTr("No default remote nodes available") + translationManager.emptyString
                Layout.bottomMargin: 6 * scaleRatio
            }

            ColumnLayout {
                anchors.margins: 0
                Layout.topMargin: 20
                Layout.fillWidth: true
                spacing: 5 * scaleRatio

                ListView {
                    visible: getRemoteNodeList().length > 0
                    height: 200 * scaleRatio
                    Layout.fillWidth: true
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model: getRemoteNodeList()

                    delegate: Rectangle {
                        color: "transparent"
                        height: 34 * scaleRatio
                        Layout.fillWidth: true

                        LokiComponents.StandardButton {
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
                            color: LokiComponents.Style.defaultFontColor
                            font.family: LokiComponents.Style.fontRegular.name
                            font.pixelSize: 14 * scaleRatio
                            text: "Address: " + modelData
                        }
                    }
                }

                Rectangle {
                    Layout.preferredHeight: 1 * scaleRatio
                    Layout.fillWidth: true
                    color: LokiComponents.Style.dividerColor
                    opacity: LokiComponents.Style.dividerOpacity
                }
            }

        }

        ColumnLayout {
            id: remoteNodeLayout
            anchors.margins: 0
            spacing: 20 * scaleRatio
            Layout.fillWidth: true
            Layout.topMargin: 20
            visible: !isMobile && persistentSettings.useRemoteNode

            LokiComponents.RemoteNodeEdit {
                id: remoteNodeEdit
                Layout.minimumWidth: 200 * scaleRatio

                lineEditBackgroundColor: "transparent"
                lineEditFontColor: "white"
                lineEditFontBold: false
                placeholderFontSize: 15 * scaleRatio

                daemonAddrLabelText: qsTr("Address")
                daemonPortLabelText: qsTr("Port")

                property var rna: persistentSettings.remoteNodeAddress
                daemonAddrText: rna.search(":") != -1 ? rna.split(":")[0].trim() : ""
                daemonPortText: rna.search(":") != -1 ? (rna.split(":")[1].trim() == "") ? "" : rna.split(":")[1] : ""
                onEditingFinished: {
                    persistentSettings.remoteNodeAddress = remoteNodeEdit.getAddress();
                    console.log("setting remote node to " + persistentSettings.remoteNodeAddress)
                }
            }

            GridLayout {
                columns: (isMobile) ? 1 : 2
                columnSpacing: 32

                LokiComponents.LineEdit {
                    id: daemonUsername
                    Layout.fillWidth: true
                    labelText: "Daemon Username"
                    text: persistentSettings.daemonUsername
                    placeholderText: qsTr("(optional)") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio
                }

                LokiComponents.LineEdit {
                    id: daemonPassword
                    Layout.fillWidth: true
                    labelText: "Daemon Password"
                    text: persistentSettings.daemonPassword
                    placeholderText: qsTr("Password") + translationManager.emptyString
                    echoMode: TextInput.Password
                }
            }

            Rectangle {
                id: rectConnectRemote
                Layout.topMargin: 12 * scaleRatio
                color: LokiComponents.Style.buttonBackgroundColor
                width: btnConnectRemote.width + 40
                height: 26

                Text {
                    id: btnConnectRemote
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: LokiComponents.Style.defaultFontColor
                    font.family: LokiComponents.Style.fontRegular.name
                    font.pixelSize: 14 * scaleRatio
                    font.bold: true
                    text: qsTr("Connect") + translationManager.emptyString
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        // Update daemon login
                        persistentSettings.remoteNodeAddress = remoteNodeEdit.getAddress();
                        persistentSettings.daemonUsername = daemonUsername.text;
                        persistentSettings.daemonPassword = daemonPassword.text;
                        persistentSettings.useRemoteNode = true
    
                        currentWallet.setDaemonLogin(persistentSettings.daemonUsername, persistentSettings.daemonPassword);
    
                        appWindow.connectRemoteNode()
                    }
                }
            }
        }

        ColumnLayout {
            id: localNodeLayout
            anchors.margins: 0
            spacing: 20 * scaleRatio
            Layout.topMargin: 40
            anchors.left: parent.left
            anchors.right: parent.right
            visible: !isMobile && !persistentSettings.useRemoteNode

            RowLayout {
                LokiComponents.LineEditMulti {
                    id: blockchainFolder
                    Layout.preferredWidth: 200
                    Layout.fillWidth: true
                    property string style: "<style type='text/css'>a {cursor:pointer;text-decoration: none; color: #78BE20}</style>"
                    labelText: qsTr("Blockchain Location") + style + qsTr(" <a href='#'> (change)</a>") + translationManager.emptyString
                    placeholderText: qsTr("(default)") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio
                    text: {
                        if(persistentSettings.blockchainDataDir.length > 0){
                            return persistentSettings.blockchainDataDir;
                        } else { return "" }
                    }
                    addressValidation: false
                    onInputLabelLinkActivated: {
                        //mouse.accepted = false
                        if(persistentSettings.blockchainDataDir !== ""){
                            blockchainFileDialog.folder = "file://" + persistentSettings.blockchainDataDir;
                        }
                        blockchainFileDialog.open();
                        blockchainFolder.focus = true;
                    }
                }
            }

            RowLayout {
                id: daemonFlagsRow

                LokiComponents.LineEditMulti {
                    id: daemonFlags
                    Layout.preferredWidth:  200
                    Layout.fillWidth: true
                    labelText: qsTr("Daemon Startup Flags") + translationManager.emptyString
                    placeholderText: qsTr("(optional)") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio
                    text: appWindow.persistentSettings.daemonFlags
                    addressValidation: false
                }
            }

            RowLayout {
                visible: !isMobile && !persistentSettings.useRemoteNode

                ColumnLayout {
                    Layout.fillWidth: true

                    LokiComponents.RemoteNodeEdit {
                        id: bootstrapNodeEdit
                        Layout.minimumWidth: 100 * scaleRatio
                        Layout.bottomMargin: 20 * scaleRatio
    
                        lineEditBackgroundColor: "transparent"
                        lineEditFontColor: "white"
                        placeholderFontSize: 15 * scaleRatio
                        lineEditFontBold: false

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
                        onEditingFinished: {
                            persistentSettings.bootstrapNodeAddress = daemonAddrText ? bootstrapNodeEdit.getAddress() : "";
                            console.log("setting bootstrap node to " + persistentSettings.bootstrapNodeAddress)
                        }
                    }
                }
            }

            LokiComponents.StandardButton {
                id: startDaemonButton
                small: true
                visible: !appWindow.daemonRunning
                text: qsTr("Start Local Node") + translationManager.emptyString
                onClicked: {
                    persistentSettings.bootstrapNodeAddress = bootstrapNodeEdit.daemonAddrText ? bootstrapNodeEdit.getAddress() : "";
                    appWindow.currentDaemonAddress = appWindow.localDaemonAddress;
                    appWindow.startDaemon(daemonFlags.text);
                }
            }

            LokiComponents.StandardButton {
                id: stopDaemonButton
                small: true
                visible: appWindow.daemonRunning
                text: qsTr("Stop Local Node") + translationManager.emptyString
                onClicked: {
                    appWindow.stopDaemon()
                }
            }

        } 
    }
}

