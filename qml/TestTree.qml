import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

WidgetFrame{

	Rectangle {
	   id: objRoot
	   objectName: "objRoot"

		anchors.fill:parent			
		anchors.margins: 5
		anchors.topMargin: 15
	   
	   color: "white"
	   ListModel {
		  id: objModel
		  objectName: "objModel"
	   }
	   Component {
		  id: objRecursiveDelegate
		  Column {
			 id: objRecursiveColumn
			 objectName: "objRecursiveColumn"
			 property int m_iIndex: model.index
			 property var m_parentModel: model.parentModel
			 clip: true
			 MouseArea {
				id: objMouseArea
				objectName: "objMouseArea"
				width: objRow.implicitWidth
				height: objRow.implicitHeight
				onDoubleClicked: {
				   for(var i = 0; i < parent.children.length; ++i) {
					  if(parent.children[i].objectName !== "objMouseArea") {
						 parent.children[i].visible = !parent.children[i].visible
					  }
				   }
				}
				drag.target: objDragRect
				onReleased: {
				   if(objDragRect.Drag.target) {
					  objDragRect.Drag.drop()
				   }
				}
				Row {
				   id: objRow
				   Item {
					  id: objIndentation
					  height: 20
					  width: model.level * 20
				   }
				   Rectangle {
					  id: objDisplayRowRect
					  height: objNodeName.implicitHeight + 5
					  width: objCollapsedStateIndicator.width + objNodeName.implicitWidth + 5
					  border.color: "green"
					  border.width: 2
					  color: "#31312c"
					  DropArea {
						 keys: [model.parentModel]
						 anchors.fill: parent
						 onEntered: objValidDropIndicator.visible = true
						 onExited: objValidDropIndicator.visible = false
						 onDropped: {
							objValidDropIndicator.visible = false
							if(drag.source.m_objTopParent.m_iIndex !== model.index) {
							   objRecursiveColumn.m_parentModel.move(
										drag.source.m_objTopParent.m_iIndex,
										model.index,
										1
										)
							}
						 }
						 Rectangle {
							id: objValidDropIndicator
							anchors.fill: parent
							visible: false
							onVisibleChanged: {
							   visible ? objAnim.start() : objAnim.stop()
							}
							SequentialAnimation on color {
							   id: objAnim
							   loops: Animation.Infinite
							   running: false
							   ColorAnimation { from: "#31312c"; to: "green"; duration: 400 }
							   ColorAnimation { from: "green"; to: "#31312c"; duration: 400 }
							}
						 }
					  }
					  Rectangle {
						 id: objDragRect
						 property var m_objTopParent: objRecursiveColumn
						 Drag.active: objMouseArea.drag.active
						 Drag.keys: [model.parentModel]
						 border.color: "magenta"
						 border.width: 2
						 opacity: .85
						 states: State {
							when: objMouseArea.drag.active
							AnchorChanges {
							   target: objDragRect
							   anchors { horizontalCenter: undefined; verticalCenter: undefined }
							}
							ParentChange {
							   target: objDragRect
							   parent: objRoot
							}
						 }
						 anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
						 height: objDisplayRowRect.height
						 width: objDisplayRowRect.width
						 visible: Drag.active
						 color: "red"
						 Text {
							anchors.fill: parent
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							text: model.name
							font { bold: true; pixelSize: 18 }
							color: "blue"
						 }
					  }
					  Text {
						 id: objCollapsedStateIndicator
						 anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
						 width: 20
						 horizontalAlignment: Text.AlignHCenter
						 verticalAlignment: Text.AlignVCenter
						 text: objRepeater.count > 0 ? objRepeater.visible ? qsTr("-") : qsTr("+") : qsTr("")
						 font { bold: true; pixelSize: 18}
						 color: "yellow"
					  }
					  Text {
						 id: objNodeName
						 anchors { left: objCollapsedStateIndicator.right; top: parent.top; bottom: parent.bottom }
						 text: model.name
						 color: objRepeater.count > 0 ? "yellow" : "white"
						 font { bold: true; pixelSize: 18 }
						 verticalAlignment: Text.AlignVCenter
					  }
				   }
				}
			 }
			 Rectangle {
				id: objSeparator
				anchors { left: parent.left; right: parent.right; }
				height: 1
				color: "black"
			 }
			 Repeater {
				id: objRepeater
				objectName: "objRepeater"
				model: subNode
				delegate: objRecursiveDelegate
			 }
		  }
	   }
	   ColumnLayout {
		  objectName: "objColLayout"
		  anchors.fill: parent
		  ScrollView {
			 Layout.fillHeight: true
			 Layout.fillWidth: true
			 ListView {
				objectName: "objListView"
				model: objModel
				delegate: objRecursiveDelegate
				interactive: false
			 }
		  }
		  Window {
			 id: objModalInput
			 objectName: "objModalInput"
			 modality: Qt.ApplicationModal
			 visible: false
			 height: 30
			 width: 200
			 color: "yellow"
			 TextInput {
				anchors.fill: parent
				font { bold: true; pixelSize: 20 }
				verticalAlignment: TextInput.AlignVCenter
				horizontalAlignment: TextInput.AlignHCenter
				validator: RegExpValidator {
				   regExp: /(\d{1,},)*.{1,}/
				}
				onFocusChanged: {
				   if(focus) {
					  selectAll()
				   }
				}
				text: qsTr("node0")
				onAccepted: {
				   if(acceptableInput) {
					  objModalInput.close()
					  var szSplit = text.split(',')
					  if(szSplit.length === 1) {
						 objModel.append({"name": szSplit[0], "level": 0, "parentModel": objModel, "subNode": []})
					  }
					  else {
						 if(objModel.get(parseInt(szSplit[0])) === undefined) {
							console.log("Error - Given node does not exist !")
							return
						 }
						 var node = objModel.get(parseInt(szSplit[0]))
						 for(var i = 1; i < szSplit.length - 1; ++i) {
							if(node.subNode.get(parseInt(szSplit[i])) === undefined) {
							   console.log("Error - Given node does not exist !")
							   return
							}
							node = node.subNode.get(parseInt(szSplit[i]))
						 }
						 node.subNode.append({"name": szSplit[i], "level": i, "parentModel": node.subNode, "subNode": []})
					  }
				   }
				}
			 }
		  }
		  Button {
			 text: "add data to tree"
			 onClicked: {
				objModalInput.show()
			 }
		  }
	   }
	}
}