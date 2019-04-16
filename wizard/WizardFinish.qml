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

import QtQuick 2.2
import QtQuick.Layouts 1.1
import LokiComponents.NetworkType 1.0

import "../components"

ColumnLayout {
    Layout.leftMargin: wizardLeftMargin
    Layout.rightMargin: wizardRightMargin
    opacity: 0
    visible: false
    Behavior on opacity {
        NumberAnimation { duration: 100; easing.type: Easing.InQuad }
    }

    onOpacityChanged: visible = opacity !== 0

    function buildSettingsString() {
        var trStart = '<tr><td style="padding-top:5px;"><b>',
            trMiddle = '</b></td><td style="padding-left:10px;padding-top:5px;">',
            trEnd = "</td></tr>",
            autoDonationEnabled = wizard.settings['auto_donations_enabled'] === true,
            autoDonationText = autoDonationEnabled ? qsTr("Enabled") : qsTr("Disabled"),
            autoDonationAmount = wizard.settings["auto_donations_amount"] + " %",
            backgroundMiningEnabled = wizard.settings["allow_background_mining"] === true,
            backgroundMiningText = backgroundMiningEnabled ? qsTr("Enabled") : qsTr("Disabled"),
            nettype = appWindow.persistentSettings.nettype,
            networkText = nettype == NetworkType.TESTNET ? qsTr("Testnet") : nettype == NetworkType.STAGENET ? qsTr("Stagenet") : qsTr("Mainnet"),
            restoreHeightEnabled = wizard.settings['restore_height'] !== undefined;

        var daemonAddress = persistentSettings.daemon_address;
        if(persistentSettings.useRemoteNode)
        {
           daemonAddress = persistentSettings.remoteNodeAddress;
        }

        return "<table>"
            + trStart + qsTr("Language") + trMiddle + wizard.settings["language"] + trEnd
            + trStart + qsTr("Wallet Name") + trMiddle + wizard.settings["account_name"] + trEnd
            // TODO: wizard.settings['wallet'].seed doesnt work anymore; yields undefined.
//            + trStart + qsTr("Backup Seed") + trMiddle + wizard.settings["wallet"].seed + trEnd
            + trStart + qsTr("Backup Seed") + trMiddle + '****' + trEnd
            + trStart + qsTr("Wallet Path") + trMiddle + wizard.settings["wallet_path"] + trEnd
            // + trStart + qsTr("Auto Donations") + trMiddle + autoDonationText + trEnd
            // + (autoDonationEnabled
                // ? trStart + qsTr("Donation Mmount") + trMiddle + autoDonationAmount + trEnd
                // : "")
            // + trStart + qsTr("Background Mining") + trMiddle + backgroundMiningText + trEnd
            + trStart + qsTr("Daemon Address") + trMiddle + daemonAddress + trEnd
            + trStart + qsTr("Network Type") + trMiddle + networkText + trEnd
            + (restoreHeightEnabled
                ? trStart + qsTr("Restore Height") + trMiddle + wizard.settings['restore_height'] + trEnd
                : "")
            + "</table>"
            + translationManager.emptyString;
    }

    function updateSettingsSummary() {
        if (!isMobile){
            settingsText.text = qsTr("New Wallet Details:") + translationManager.emptyString
                                + "<br>"
                                + buildSettingsString();
        } else {
            settingsText.text = qsTr("Don't forget to write down your seed. You can view your seed and change your settings on settings page.")
        }


    }

    function onPageOpened(settings) {
        updateSettingsSummary();
        wizard.nextButton.visible = false;
    }


    RowLayout {
        id: dotsRow
        Layout.alignment: Qt.AlignRight

        ListModel {
            id: dotsModel
            ListElement { dotColor: "#36B05B" }
            ListElement { dotColor: "#36B05B" }
            ListElement { dotColor: "#36B05B" }
            ListElement { dotColor: "#FFE00A" }
        }

        Repeater {
            model: dotsModel
            delegate: Rectangle {
                width: 12; height: 12
                radius: 6
                color: dotColor
            }
        }
    }

    ColumnLayout {
        id: headerColumn
        Layout.fillWidth: true

        Text {
            Layout.fillWidth: true
            font.family: "Arial"
            font.pixelSize: 28 * scaleRatio
            wrapMode: Text.Wrap
            //renderType: Text.NativeRendering
            color: Style.defaultFontColor
            text: qsTr("You’re All Set Up!") + translationManager.emptyString
        }

        Text {
            Layout.fillWidth: true
            id: settingsText
            font.family: "Arial"
            font.pixelSize: 16 * scaleRatio
            wrapMode: Text.Wrap
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHLeft
            //renderType: Text.NativeRendering
            color: Style.defaultFontColor
        }
    }
}
