import QtQuick 2.0

import "../components" as XtendcashComponents

TextEdit {
    color: XtendcashComponents.Style.defaultFontColor
    font.family: XtendcashComponents.Style.fontRegular.name
    selectionColor: XtendcashComponents.Style.dimmedFontColor
    wrapMode: Text.Wrap
    readOnly: true
    selectByMouse: true
    // Workaround for https://bugreports.qt.io/browse/QTBUG-50587
    onFocusChanged: {
        if(focus === false)
            deselect()
    }
}
