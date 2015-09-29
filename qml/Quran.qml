import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0

import QtGraphicalEffects 1.0

WidgetFrame{

	Item {
		id: root

		anchors.fill:parent			
		anchors.margins: 5
		anchors.topMargin: 15
		MTreeView{
			model: listModel
		}
		
		ListModel {
			id:listModel
			ListElement {label: "اول"; elements: []}
			ListElement {
				label: "دوم"
				elements: [
					ListElement {
						label: "دوم - ۲"
						elements: [
							ListElement {
								label: "دوم ۳"
								elements: []
							}
						]
					},
					ListElement {label: "سوم"; elements: []},
					ListElement {label: "چهارم"; elements: []}
				]
			}
			ListElement {label: "پنجم"; elements: []}
		}

	}
}
