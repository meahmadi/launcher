
import QtQuick 2
import QtQuick.Window 2.2
import QtQuick.Particles 2.0

Item {
	id:page
	
	property real xsc : width/Screen.width
	property real ysc : height/Screen.height

	Sky{
		id: sky
		anchors.fill: parent;
	}

	Land{
		id: land
		anchors.fill: parent;
	}	
	
	Frame{
		id:frame
		anchors.fill: parent;
	}
	

	/*FixButton{
		text:"آسمان"
		xpos: 100
		ypos: 100
		onClicked: {
			sky.current = ((sky.current+1) % 9) + 1;
			sky.img.source = "sky/00" + sky.current + ".png";
		}
	}*/
	
	Holoview{
		id:view
	}
}
