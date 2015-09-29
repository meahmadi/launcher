import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.2

import QtGraphicalEffects 1.0

ListView {
	id: rootView
	anchors.fill: parent
	delegate: groupsDelegate
	property bool rtl:true
	
	Component {
		id: groupsDelegate

		Item {
			id: container
			width: rootView.height
			height: childrenRect.height
		
			ColumnLayout {
				x: 14
				id: mainColumn
				
				RowLayout {
					id: mainRow
					spacing: 3
					property bool expanded: false

					Image {
						id: expander
						source: "icons/expander.png"
						rotation: mainRow.expanded ? 90 : 0
						opacity: elements.count === 0 ? 0 : 1
						Behavior on rotation {
							NumberAnimation {duration: 110}
						}

						MouseArea {
							visible: expander.opacity === 1 ? true : false
							id: expanderMouseArea
							anchors.fill: parent
							onClicked: {
								mainRow.expanded = !mainRow.expanded
								console.log(container.height)
							}
						}
					}

					Text {
						id: name
						text: label
						color: "white"
						MouseArea{
							anchors.fill: parent
							onDoubleClicked:{
								mainRow.expanded = !mainRow.expanded
							}
						}
					}
				}

				Item {
					width: container.width-mainColumn.x
					height: childView.contentHeight
					visible: mainRow.expanded

					ListView {
						id: childView
						anchors.fill: parent
						model: elements
						delegate: groupsDelegate
					}
				}
			}

		}
	}

}