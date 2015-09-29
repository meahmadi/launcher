import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1

import QtGraphicalEffects 1.0

WidgetFrame{
		
		FolderListModel {
			id: folderModel
			nameFilters: ["*.*"]
		}		
		TreeView {
			anchors.fill:parent			
			anchors.margins: 5
			anchors.topMargin: 15
			
			TableViewColumn {
				title: "Name"
				role: "fileName"
				width: 300
			}
			TableViewColumn {
				title: "Permissions"
				role: "filePermissions"
				width: 100
			}
			model: folderModel
		}
	}