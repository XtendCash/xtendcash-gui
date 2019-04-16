// Copyright (c) 2018, The Loki Project
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

import QtQuick 2.0
import QtQuick.Layouts 1.1

import LokiComponents.Wallet 1.0
import "../components" as LokiComponents

Rectangle {
    id: item
    color: "#1a1a1a"
    property var connected: Wallet.ConnectionStatus_Disconnected

    function getConnectionStatusString(status) {
        if (status == Wallet.ConnectionStatus_Connected) {
            if(!appWindow.daemonSynced)
                return qsTr("Synchronizing")
            if(appWindow.remoteNodeConnected)
                return qsTr("Remote Node")
            return qsTr("Connected")
        }
        if (status == Wallet.ConnectionStatus_WrongVersion)
            return qsTr("Wrong version")
        if (status == Wallet.ConnectionStatus_Disconnected)
            return qsTr("Disconnected")
        return qsTr("Invalid connection status")
    }

    RowLayout {
        Layout.preferredHeight: 40 * scaleRatio

        Item {
            id: iconItem
            anchors.top: parent.top
            width: 40 * scaleRatio
            height: 40 * scaleRatio
            opacity: {
                if(item.connected == Wallet.ConnectionStatus_Connected){
                    return 1
                } else {
                    return 0.5
                }
            }

            Image {
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.right: parent.right
                anchors.rightMargin: 11
                source: {
                    if(item.connected == Wallet.ConnectionStatus_Connected){
                        return "../images/lightning.png"
                    } else {
                        return "../images/lightning-white.png"
                    }
                }
            }
        }

        Item {
            anchors.top: parent.top
            anchors.left: iconItem.right
            height: 40 * scaleRatio
            width: 260 * scaleRatio

            Text {
                id: statusText
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 0
                font.family: LokiComponents.Style.fontMedium.name
                font.bold: true
                font.pixelSize: 13 * scaleRatio
                color: "white"
                opacity: 0.5
                text: qsTr("Network Status") + translationManager.emptyString
            }

            Text {
                id: statusTextVal
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 14
                font.family: LokiComponents.Style.fontMedium.name
                font.pixelSize: 20 * scaleRatio
                color: "white"
                text: getConnectionStatusString(item.connected) + translationManager.emptyString
            }

            Text {
                id: nodeAddr
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 40
                font.family: LokiComponents.Style.fontMedium.name
                font.pixelSize: 12 * scaleRatio
                color: LokiComponents.Style.dimmedFontColor
                text: (appWindow.currentDaemonAddress == ":") ? "Daemon Address Not Set" : appWindow.currentDaemonAddress
            }
        }
    }


}
