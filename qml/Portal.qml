
import QtQuick 2
import QtQuick.Particles 2.0

Item {
	id:page
    width: 1024; height: 768;

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
	
	Column{
			anchors.left: frame.left
			anchors.top: frame.top
		TXTButton{
			text:"آسمان"
			onClicked: {
				sky.current = ((sky.current+1) % 9) + 1;
				sky.img.source = "sky/00" + sky.current + ".png";
			}
		}
		TXTButton{
			text:"درگاه"
			onClicked: {
				frame.current = ((frame.current+1) % 5) + 1;
				frame.img.source = "frame/00" + frame.current + ".png";			
			}
		}
		TXTButton{
			text:"زمین"
			onClicked: {
				land.current = ((land.current+1) % 3) + 1;
				land.img.source = "land/00" + land.current + ".png";			
			}
		}
	}
}
