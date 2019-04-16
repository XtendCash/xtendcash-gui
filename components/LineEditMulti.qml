// Copyright (c) 2018, The Loki Project
// Copyright (c) 2014-2015, The Monero Project
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

import "../components" as LokiComponents

ColumnLayout {
    id: item

    Layout.fillWidth: true
    Layout.preferredHeight: childrenRect.height

    property alias text: input.text
    property alias labelText: inputLabel.text
    property alias labelButtonText: labelButton.text
    property alias placeholderText: placeholderLabel.text

    property bool placeholderCenter: false
    property string placeholderFontFamily: LokiComponents.Style.fontRegular.name
    property bool placeholderFontBold: false
    property int placeholderFontSize: 18 * scaleRatio
    property string placeholderColor: LokiComponents.Style.defaultFontColor
    property real placeholderOpacity: 0.35

    property bool borderDisabled: false
    property string borderColor: {
        if(input.error && input.text !== ""){
            return LokiComponents.Style.inputBorderColorInvalid;
        } else if(input.activeFocus) {
            return LokiComponents.Style.heroGreen;
        } else {
            return LokiComponents.Style.inputBorderColorInActive;
        }
    }

    property bool error: false

    property string labelFontColor: LokiComponents.Style.defaultFontColor
    property bool labelFontBold: false
    property int labelFontSize: 16 * scaleRatio
    property bool labelButtonVisible: false

    property string fontColor: "white"
    property bool fontBold: false
    property int fontSize: 16 * scaleRatio

    property bool mouseSelection: true
    property alias readOnly: input.readOnly
    property bool copyButton: false
    property bool showingHeader: true
    property var wrapMode: Text.NoWrap
    property alias addressValidation: input.addressValidation
    property string backgroundColor: "" // mock

    signal labelButtonClicked();
    signal inputLabelLinkActivated();
    signal editingFinished();

    spacing: 0
    Rectangle {
        id: inputLabelRect
        color: "transparent"
        Layout.fillWidth: true
        height: (inputLabel.height + 10) * scaleRatio
        visible: showingHeader ? true : false

        Text {
            id: inputLabel
            anchors.top: parent.top
            anchors.left: parent.left
            font.family: LokiComponents.Style.fontRegular.name
            font.pixelSize: item.labelFontSize
            font.bold: labelFontBold
            textFormat: Text.RichText
            color: LokiComponents.Style.defaultFontColor
            onLinkActivated: inputLabelLinkActivated()

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
            }
        }

        LokiComponents.LabelButton {
            id: labelButton
            onClicked: labelButtonClicked()
            visible: labelButtonVisible
        }

        LokiComponents.LabelButton {
            id: copyButtonId
            visible: copyButton && input.text !== ""
            text: qsTr("Copy")
            anchors.right: labelButton.visible ? inputLabel.right : parent.right
            anchors.rightMargin: labelButton.visible? 4 : 0
            onClicked: {
                if (input.text.length > 0) {
                    console.log("Copied to clipboard");
                    clipboard.setText(input.text);
                    appWindow.showStatusMessage(qsTr("Copied to clipboard"), 3);
                }
            }
        }
    }

    LokiComponents.InputMulti {
        id: input
        readOnly: false
        addressValidation: false
        anchors.top: item.showingHeader ? inputLabelRect.bottom : item.top
        Layout.fillWidth: true
        topPadding: item.showingHeader ? 10 * scaleRatio : 0
        bottomPadding: 10 * scaleRatio
        wrapMode: item.wrapMode
        fontSize: item.fontSize
        fontBold: item.fontBold
        fontColor: item.fontColor
        mouseSelection: item.mouseSelection
        onEditingFinished: item.editingFinished()
        error: item.error

        Text {
            id: placeholderLabel
            visible: input.text ? false : true
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10 * scaleRatio
            opacity: item.placeholderOpacity
            color: item.placeholderColor
            font.family: item.placeholderFontFamily
            font.bold: item.placeholderFontBold
            font.pixelSize: item.placeholderFontSize
            text: ""
            z: 3
        }

        Rectangle {
            color: "transparent"
            border.width: 1
            border.color: item.borderColor
            anchors.fill: parent
            visible: !item.borderDisabled
        }
    }
}
