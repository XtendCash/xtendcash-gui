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

import "../components" as LokiComponents

RowLayout {
    id: radioButton
    property alias text: label.text
    property bool checked: false
    property int fontSize: 14 * scaleRatio
    property alias fontColor: label.color
    signal clicked()
    height: 26 * scaleRatio
    // legacy properties
    property var checkedColor: LokiComponents.Style.heroGreen
    property var borderColor: checked ? LokiComponents.Style.heroGreen : Qt.rgba(1, 1, 1, 0.25)

    function toggle(){
        radioButton.checked = !radioButton.checked
        radioButton.clicked()
    }

    RowLayout {
        Layout.fillWidth: true
        Rectangle {
            id: button
            anchors.left: parent.left
            y: 0
            color: "transparent"
            border.color: borderColor
            width: radioButton.height
            height: radioButton.height
            radius: radioButton.height

            Rectangle {
                visible: radioButton.checked
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: checkedColor
                width: 10 * scaleRatio
                height: 10 * scaleRatio
                radius: 10
                opacity: 0.8
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    toggle()
                }
            }
        }

        Text {
            id: label
            anchors.left: button.right
            anchors.leftMargin: !isMobile ? 10 : 8
            color: LokiComponents.Style.defaultFontColor
            font.family: LokiComponents.Style.fontRegular.name
            font.pixelSize: radioButton.fontSize
            wrapMode: Text.Wrap

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    toggle()
                }
            }
        }
    }
}
