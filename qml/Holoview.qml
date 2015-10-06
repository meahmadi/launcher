import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1

import QtGraphicalEffects 1.0

Rectangle{
	id: holoview
	color:"transparent"
	border.width:2
	border.color:"blue"
	
	radius: 5
	
	anchors.fill: parent
	anchors.margins: 40
	
	Bozorgrah{
		basey:100
		basex:100
	}

	TestFileWidget{
		basey:100
		basex:50
	}
	Quran{
		basex:800
	}
	
}