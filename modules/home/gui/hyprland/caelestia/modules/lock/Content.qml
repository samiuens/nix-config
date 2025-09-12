import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    required property var lock

    spacing: Appearance.spacing.large * 2
    
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Appearance.spacing.normal
    }

    Center {
        lock: root.lock
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: Appearance.spacing.normal
    }
}
