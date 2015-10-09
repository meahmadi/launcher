
import QtQuick 2
import QtQuick.Particles 2.0

Item {
	id:landitem
	property Item img: landimage
	Image{
			id:landimage
			source : "land/006.png";
			asynchronous: true;
			fillMode: Image.Stretch ;
			anchors.fill: parent;
			smooth: true			
		}
	
	
}
