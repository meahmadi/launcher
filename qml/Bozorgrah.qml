import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtWebKit 3.0
import QtGraphicalEffects 1.0

import Bozorgrah 1.0

WidgetFrame{

	Bozorgrah{
		id:bz
		server:"https://bz.bozorgrah.net"
		username:"me_ahmadi"
		password:"meisam"
		Component.onCompleted:{
			//bz.getCurrentData()
			bz.getCurrentDataFromFile()
		}
	}

	Text{
		text:"Click On me to reload log"
		
		anchors.fill: parent
		anchors.margins: 5
		anchors.topMargin: 15
		MouseArea{
			anchors.fill : parent
			onClicked:{
				parent.text = bz.log
			}
		}
	}
	normalwidth: 800
	normalheight: 600
}
