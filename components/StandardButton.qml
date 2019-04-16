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

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../components" as XtendcashComponents

Item {
    id: button
    property string rightIcon: ""
    property string rightIconInactive: ""
    property string icon: ""
    property string textColor: button.enabled? XtendcashComponents.Style.buttonTextColor: XtendcashComponents.Style.buttonTextColorDisabled
    property string textAlign: rightIcon !== "" ? "left" : "center"
    property bool small: false
    property alias text: label.text
    property int fontSize: {
        if(small) return 14 * scaleRatio;
        else return 16 * scaleRatio;
    }
    signal clicked()

    // Dynamic height/width
    Layout.minimumWidth: {
        var _padding = 22;
        if(button.rightIcon !== ""){
            _padding += 60;
        }

        var _width = label.contentWidth + _padding;
        if(_width <= 50) {
            return 60;
        }

        return _width;
    }

    height: small ?  30 * scaleRatio : 36 * scaleRatio

    function doClick() {
        // Android workaround
        releaseFocus();
        clicked();
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height - 1
        color: parent.enabled ? XtendcashComponents.Style.buttonBackgroundColor : XtendcashComponents.Style.buttonBackgroundColorDisabled
        border.width: parent.focus ? 1 : 0

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            propagateComposedEvents: true

            // possibly do some hover effects here
            onEntered: {
                if(button.enabled) parent.color = XtendcashComponents.Style.buttonBackgroundColorHover;
                else parent.color = XtendcashComponents.Style.buttonBackgroundColorDisabledHover;
            }
            onExited: {
                if(button.enabled) parent.color = XtendcashComponents.Style.buttonBackgroundColor;
                else parent.color = XtendcashComponents.Style.buttonBackgroundColorDisabled;
            }
        }
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: textAlign === "center" ? Text.AlignHCenter : Text.AlignLeft
        anchors.leftMargin: textAlign === "center" ? 0 : 11
        font.family: XtendcashComponents.Style.fontBold.name
        font.bold: true
        font.pixelSize: buttonArea.pressed ? button.fontSize - 1 : button.fontSize
        color: parent.textColor
        visible: parent.icon === ""
    }

    Image {
        anchors.centerIn: parent
        visible: parent.icon !== ""
        source: parent.icon
    }

    Image {
        visible: parent.rightIcon !== ""
        anchors.right: parent.right
        anchors.rightMargin: 11 * scaleRatio
        anchors.verticalCenter: parent.verticalCenter
        width: parent.small ? 16 * scaleRatio : 20 * scaleRatio
        height: parent.small ? 16 * scaleRatio : 20 * scaleRatio
        source: {
            if(parent.rightIconInactive !== "" && !parent.enabled){
                return parent.rightIconInactive;
            }
            return parent.rightIcon;
        }
    }

    MouseArea {
        id: buttonArea
        anchors.fill: parent
        onClicked: doClick()
        cursorShape: Qt.PointingHandCursor
    }

    Keys.onSpacePressed: doClick()
    Keys.onReturnPressed: doClick()
}
