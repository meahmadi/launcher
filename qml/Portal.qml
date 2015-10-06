
import QtQuick 2
import QtQuick.Particles 2.0

Item {
	id:page
	
    width: 1360; height: 740;
	property real xsc : width/1360
	property real ysc : height/740

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
	

	FixButton{
		text:"آسمان"
		xpos: 100
		ypos: 100
		onClicked: {
			sky.current = ((sky.current+1) % 9) + 1;
			sky.img.source = "sky/00" + sky.current + ".png";
		}
	}
	FixButton{
		text:"درگاه"
		xpos: 100
		ypos: 150
		onClicked: {
			frame.current = ((frame.current+1) % 5) + 1;
			frame.img.source = "frame/00" + frame.current + ".png";			
		}
	}
	FixButton{
		text:"زمین"
		xpos: 100
		ypos: 200
		onClicked: {
			land.current = ((land.current+1) % 3) + 1;
			land.img.source = "land/00" + land.current + ".png";			
		}
	}

	
	Holoview{
		id:view
	}
}
