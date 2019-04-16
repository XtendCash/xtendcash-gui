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
import QtQuick.Dialogs 1.2

import "../../version.js" as Version
import "../../components" as XtendcashComponents


Rectangle {
    color: "transparent"
    height: 1400
    Layout.fillWidth: true

    ColumnLayout {
        id: infoLayout
        Layout.fillWidth: true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: (isMobile)? 17 : 20
        anchors.topMargin: 0
        spacing: 30

        GridLayout {
            columns: 2
            columnSpacing: 0

            XtendcashComponents.TextBlock {
                font.pixelSize: 14
                text: qsTr("GUI version: ") + translationManager.emptyString
            }

            XtendcashComponents.TextBlock {
                font.pixelSize: 14
                text: Version.GUI_VERSION + " (Qt " + qtRuntimeVersion + ")" + translationManager.emptyString
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            XtendcashComponents.TextBlock {
                id: guiXtendcashVersion
                font.pixelSize: 14
                text: qsTr("Embedded Xtendcash Version: ") + translationManager.emptyString
            }

            XtendcashComponents.TextBlock {
                font.pixelSize: 14
                text: Version.GUI_XTEND_VERSION + translationManager.emptyString
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            XtendcashComponents.TextBlock {
                Layout.fillWidth: true
                font.pixelSize: 14
                text: qsTr("Wallet path: ") + translationManager.emptyString
            }

            XtendcashComponents.TextBlock {
                Layout.fillWidth: true
                Layout.maximumWidth: 360
                font.pixelSize: 14
                text: {
                    var wallet_path = walletPath();
                    if(isIOS)
                        wallet_path = xtendcashAccountsDir + wallet_path;
                    return wallet_path;
                }
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            XtendcashComponents.TextBlock {
                id: restoreHeight
                font.pixelSize: 14
                textFormat: Text.RichText
                text: (typeof currentWallet == "undefined") ? "" : qsTr("Wallet creation height: ") + translationManager.emptyString
            }

            XtendcashComponents.TextBlock {
                id: restoreHeightText
                Layout.fillWidth: true
                textFormat: Text.RichText
                font.pixelSize: 14
                font.bold: true
                property var style: "<style type='text/css'>a {cursor:pointer;text-decoration: none; color: #78BE20}</style>"
                text: (currentWallet ? currentWallet.walletCreationHeight : "") + style + qsTr(" <a href='#'> (Click to change)</a>") + translationManager.emptyString
                onLinkActivated: {
                    inputDialog.labelText = qsTr("Set a new restore height:") + translationManager.emptyString;
                    inputDialog.inputText = currentWallet ? currentWallet.walletCreationHeight : "0";
                    inputDialog.onAcceptedCallback = function() {
                        var _restoreHeight = parseInt(inputDialog.inputText);
                        if (!isNaN(_restoreHeight)) {
                            if(_restoreHeight >= 0) {
                                currentWallet.walletCreationHeight = _restoreHeight
                                // Restore height is saved in .keys file. Set password to trigger rewrite.
                                currentWallet.setPassword(appWindow.walletPassword)

                                // Show confirmation dialog
                                confirmationDialog.title = qsTr("Rescan wallet cache") + translationManager.emptyString;
                                confirmationDialog.text  = qsTr("Are you sure you want to rebuild the wallet cache?\n"
                                                                + "The following information will be deleted\n"
                                                                + "- Recipient addresses\n"
                                                                + "- Tx keys\n"
                                                                + "- Tx descriptions\n\n"
                                                                + "The old wallet cache file will be renamed and can be restored later.\n"
                                                                );
                                confirmationDialog.icon = StandardIcon.Question
                                confirmationDialog.cancelText = qsTr("Cancel")
                                confirmationDialog.onAcceptedCallback = function() {
                                    walletManager.closeWallet();
                                    walletManager.clearWalletCache(persistentSettings.wallet_path);
                                    walletManager.openWalletAsync(persistentSettings.wallet_path, appWindow.walletPassword,
                                                                      persistentSettings.nettype);
                                }

                                confirmationDialog.onRejectedCallback = null;
                                confirmationDialog.open()
                                return;
                            }
                        }

                        appWindow.showStatusMessage(qsTr("Invalid restore height specified. Must be a number."),3);
                    }
                    inputDialog.onRejectedCallback = null;
                    inputDialog.open()
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton
                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            Rectangle {
                height: 1
                Layout.topMargin: 2 * scaleRatio
                Layout.bottomMargin: 2 * scaleRatio
                Layout.fillWidth: true
                color: XtendcashComponents.Style.dividerColor
                opacity: XtendcashComponents.Style.dividerOpacity
            }

            XtendcashComponents.TextBlock {
                Layout.fillWidth: true
                font.pixelSize: 14
                text: qsTr("Wallet log path: ") + translationManager.emptyString
            }

            XtendcashComponents.TextBlock {
                Layout.fillWidth: true
                font.pixelSize: 14
                text: walletLogPath
            }
        }

        // Copy info to clipboard
        Rectangle {
            color: "transparent"
            Layout.preferredHeight: 24 * scaleRatio
            Layout.fillWidth: true

            Rectangle {
                id: rectCopy
                color: XtendcashComponents.Style.buttonBackgroundColor
                width: btnCopy.width + 40
                height: 24

                Text {
                    id: btnCopy
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: XtendcashComponents.Style.defaultFontColor
                    font.family: XtendcashComponents.Style.fontRegular.name
                    font.pixelSize: 14 * scaleRatio
                    font.bold: true
                    text: qsTr("Copy To Clipboard") + translationManager.emptyString
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        var data = "";
                        data += "GUI Version: " + Version.GUI_VERSION + " (Qt " + qtRuntimeVersion + ")";
                        data += "\nEmbedded Xtendcash Version: " + Version.GUI_XTEND_VERSION;
                        data += "\nWallet Path: ";

                        var wallet_path = walletPath();
                        if(isIOS)
                            wallet_path = xtendcashAccountsDir + wallet_path;
                        data += wallet_path;

                        data += "\nWallet Creation Height: ";
                        if(currentWallet)
                            data += currentWallet.walletCreationHeight;

                        data += "\nWallet Log Path: " + walletLogPath;

                        console.log("Copied to clipboard");
                        clipboard.setText(data);
                        appWindow.showStatusMessage(qsTr("Copied To Clipboard"), 3);
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        
    }
}
