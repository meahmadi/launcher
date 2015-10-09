
import QtQuick 2
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4



Item {
	id:page
    width: 1100; height: 700;
	Loader{
		id:pageloader
		anchors.fill:page
	}

/*	ComboBox{
		id:modelcombo
		currentIndex:2
		width:70
		model: ListModel{
			id: framemodel
			ListElement{ src:"Landscape.qml"; text:"منظره"}
			ListElement{ src:"Helipit.qml"; text:"هلی کوپتر"}
			ListElement{ src:"Portal.qml"; text:"درگاه"}
		}
		onCurrentIndexChanged : {
			pageloader.source= framemodel.get(modelcombo.currentIndex).src
		}
		
		anchors.bottom:page.bottom
		anchors.left:page.left
	}*/	
	
	Component.onCompleted:{
		pageloader.source= "Portal.qml"//framemodel.get(modelcombo.currentIndex).src
	}
}
