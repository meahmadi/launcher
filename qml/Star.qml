
import QtQuick 2
import QtQuick.LocalStorage 2.0

Item{
	id:star;
	signal clicked;
	
	
	property real childspace: 30;
	property real childratio: 0.8;
	
	property real animationscale:0.1
	property real animationtime:10000
	
	property real basespace:0
	property real basex:0
	property real basey:0
	
	property bool childsvisible: false
	
	property string guid:""
	
	property string text
	
	property var childs: []
	
	width:childspace
	height:width
	
	Text{
		id:caption
		text: star.text
		visible:marea.containsMouse
		color: "white"
		anchors.top: starimg.bottom
		anchors.horizontalCenter: starimg.horizontalCenter
		font.family: "B Lotus"
		font.bold: true
		font.pointSize: star.childspace*0.5
	}
	Image{
		id:starimg
		fillMode: Image.PreserveAspectCrop;
		anchors.fill: star
		
		source : "icons/star.png"
		NumberAnimation on rotation { from: 0; to: 360; duration: 20000; loops: Animation.Infinite }		
	}
	Item{
		id:childArea
		anchors.fill:parent
		visible: false
	}
	MouseArea{
		id:marea
		anchors.fill:parent;
		hoverEnabled: true;
		onDoubleClicked:{
			star.clicked();
		}
		onClicked:{
			star.childsvisible = !star.childsvisible
			childArea.visible =  star.childsvisible
		}
		onEntered:{
			childArea.visible = true
		}
		onExited:{
			childArea.visible = false | star.childsvisible
		}
	}
	
	function loadTree(){
		var Star = Qt.createComponent("Star.qml");
	
		var db = LocalStorage.openDatabaseSync("stardb", "1.0", "The Stars Tree Database", 1000000);
		db.transaction(
			function(tx){
				tx.executeSql('create table if not exists stars(guid text, name text, parent_guid text, sibling_index int)');
				if (star.guid == ""){
					star.guid = exutils.newUUID;
					tx.executeSql('insert into stars (guid, name, parent_guid, sibling_index) values (?,?,?,?)',[star.guid, star.text, "-1", -1]);
				}else{
					var rs = tx.executeSql('select name from stars where guid=?',[star.guid]);
					if(rs.rows.length==0)
						tx.executeSql('insert into stars( guid, name, parent_guid, sibling_index) values (?,?,?,?)',[star.guid, star.text, "-1", -1]);
					else{
						star.text = rs.rows.item(0).name;
					}
					var nrs = tx.executeSql('select name,guid from stars where parent_guid=?',[star.guid]);
					for(var i=0; i<nrs.rows.length; i++){
							var x = (-1*nrs.rows.length*star.childspace)+((i*2+1)*star.childspace);
							star.childs.push(Star.createObject(childArea,{ "guid":nrs.rows.item(i).guid , "basex":x, "basey":star.childspace, "childspace":star.childspace*star.childratio}));
					}
				}
			}
		);
	}
	SequentialAnimation on x {
		loops: Animation.Infinite;
		NumberAnimation { from: star.basex*(1-animationscale); to: star.basex*(1+animationscale); duration: animationtime;  easing.type: Easing.InOutQuad  }				
		NumberAnimation { from: star.basex*(1+animationscale); to: star.basex*(1-animationscale); duration: animationtime;  easing.type: Easing.InOutQuad  }
	}
	SequentialAnimation on y {
		loops: Animation.Infinite;
		NumberAnimation { from: star.basey*(1-animationscale); to: star.basey*(1+animationscale); duration: animationtime;  easing.type: Easing.InOutQuad  }				
		NumberAnimation { from: star.basey*(1+animationscale); to: star.basey*(1-animationscale); duration: animationtime;  easing.type: Easing.InOutQuad  }
	}
	
	Component.onCompleted: loadTree()	
}	
