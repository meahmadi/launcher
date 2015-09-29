import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

WidgetFrame{

	Item {
		id: root

		anchors.fill:parent			
		anchors.margins: 5
		anchors.topMargin: 15

		ListView {
			id: rootView
			anchors.fill: parent
			delegate: groupsDelegate
			model: listModel
			//highlight: Rectangle {color: "lightsteelblue"; radius: 6}
			Component {
				id: groupsDelegate

				Item {
					id: container
					width: rootView.height
					height: childrenRect.height

					Column {
						x: 14
						id: mainColumn

						Row {
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
								text: group
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
							width: container.width//-mainColumn.x
							height: childView.contentHeight
							visible: mainRow.expanded

							ListView {
								id: childView
								anchors.fill: parent
								model: elements
								delegate: groupsDelegate
								//highlight: Rectangle {color: "lightsteelblue"; radius: 5}
							}
						}
					}

				}
			}

			ListModel {
				id:listModel
				ListElement {group: "first"; elements: []}
				ListElement {
					group: "second"
					elements: [
						ListElement {
							group: "second2"
							elements: [
								ListElement {
									group: "second2.2"
									elements: []
								}
							]
						},
						ListElement {group: "second3"; elements: []},
						ListElement {group: "second4"; elements: []}
					]
				}
				ListElement {group: "third"; elements: []}
			}
		}
	}
}