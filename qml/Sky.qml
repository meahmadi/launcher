
import QtQuick 2
import QtQuick.Particles 2.0

Item {
	id:skyitem
	property Item img: skyimage
	Image{
			id:skyimage
			source : "sky/001.png";
			asynchronous: true;
			fillMode: Image.Stretch ;
			anchors.fill: parent;
			smooth: true;
		}
	
	Row{
		id:stars
		anchors.topMargin: skyitem.height*0.2
		anchors.top: sky.top
		anchors.horizontalCenter: sky.horizontalCenter
		spacing:20
		Star{
			guid:"-1"
		}

	}
	property int current : 0;
	
	
}
