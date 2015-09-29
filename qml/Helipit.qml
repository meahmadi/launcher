
import QtQuick 2
import QtQuick.Particles 2.0

Item {
	id:page
    width: 900; height: 600;

	Image{
		id: sky
		source : "sky/009.png"
		asynchronous: true;
		fillMode: Image.PreserveAspectCrop;
		anchors.fill: parent;
		smooth: true
	}
	Image{
		id: land
		source : "land/005.png"
		asynchronous: true;
		fillMode: Image.PreserveAspectCrop;
		anchors.fill: parent;
		smooth: true
	}	
	
	Star{
		id:stars
		anchors.topMargin: page.height*0.2
		anchors.top: sky.top
		anchors.horizontalCenter: sky.horizontalCenter
	
		guid:"-1"
	}	
	
	
	Holoview{
		id:view
	}
	
}
