
import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.LocalStorage 2.0
Item {
	id:page
    width: 1366; height: 750;
	
	property real xsc : width/1366
	property real ysc : height/750

	Image{
		id:bgimage
		source : "landscape/001.png";
		asynchronous: true;
		fillMode: Image.Stretch ;
		anchors.fill: parent;
		smooth: true;
	}
	
	FixButton{
		text:"رؤيت عالم"
		
		xpos: 400
		ypos: 200
		
		onClicked: Qt.openUrlExternally("D:/Royat/3.12/Royat/Royat.exe")
	}

	
	FixButton{
		text:"C"
		
		xpos: 100
		ypos: 100

		onClicked: Qt.openUrlExternally("c:")
	}
	
		
	TXTButton{
		id:quitbtn
		text:"خروج"
		anchors.right: page.right
		anchors.bottom: page.bottom
		onClicked: Qt.quit()
	}
	
	
	function loadObjects(){
		var components = {"star":Qt.createComponent("Star.qml"),
							"FixButton":Qt.createComponent("FixButton"),
							"TXTButton":Qt.createComponent("TXTButton")};
	
		var db = LocalStorage.openDatabaseSync("objectsdb", "1.0", "The Objects Database", 1000000);
		db.transaction(
			function(tx){
				tx.executeSql('create table if not exists pictures(guid text, name text, url text);');
				tx.executeSql('create table if not exists objects(guid text, name text, type text);');
				tx.executeSql('create table if not exists properties(guid text, name text, value text, picture text);');
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
	
	Component.onCompleted: loadObjects()
}
