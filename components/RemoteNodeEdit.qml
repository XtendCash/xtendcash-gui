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

import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick 2.2
import QtQuick.Layouts 1.1

import "../components" as LokiComponents

GridLayout {
    columns: (isMobile) ? 1 : 2
    columnSpacing: 32
    id: root
    property alias daemonAddrText: daemonAddr.text
    property alias daemonPortText: daemonPort.text
    property alias daemonAddrLabelText: daemonAddr.labelText
    property alias daemonPortLabelText: daemonPort.labelText

    // TODO: LEGACY; remove these placeHolder variables when
    // the wizards get redesigned to the black-theme
    property string placeholderFontFamily: LokiComponents.Style.fontRegular.name
    property bool placeholderFontBold: false
    property int placeholderFontSize: 18 * scaleRatio
    property string placeholderColor: LokiComponents.Style.defaultFontColor
    property real placeholderOpacity: 0.25

    property string lineEditBackgroundColor: "white"
    property string lineEditFontColor: "black"
    property int lineEditFontSize: 18 * scaleRatio
    property int labelFontSize: 16 * scaleRatio
    property bool lineEditFontBold: true

    signal editingFinished()

    function getAddress() {
        return daemonAddr.text.trim() + ":" + daemonPort.text.trim()
    }

    LineEdit {
        id: daemonAddr
        Layout.fillWidth: true
        placeholderText: qsTr("Remote Node Hostname / IP") + translationManager.emptyString
        placeholderFontFamily: root.placeholderFontFamily
        placeholderFontBold: root.placeholderFontBold
        placeholderFontSize: root.placeholderFontSize
        placeholderColor: root.placeholderColor
        placeholderOpacity: root.placeholderOpacity
        labelFontSize: root.labelFontSize
        backgroundColor: lineEditBackgroundColor
        fontColor: lineEditFontColor
        fontBold: lineEditFontBold
        fontSize: lineEditFontSize
        onEditingFinished: root.editingFinished()
    }

    LineEdit {
        id: daemonPort
        Layout.fillWidth: true
        placeholderText: qsTr("Port") + translationManager.emptyString
        placeholderFontFamily: root.placeholderFontFamily
        placeholderFontBold: root.placeholderFontBold
        placeholderFontSize: root.placeholderFontSize
        placeholderColor: root.placeholderColor
        placeholderOpacity: root.placeholderOpacity
        labelFontSize: root.labelFontSize
        backgroundColor: lineEditBackgroundColor
        fontColor: lineEditFontColor
        fontBold: lineEditFontBold
        fontSize: lineEditFontSize

        onEditingFinished: root.editingFinished()
    }
}
